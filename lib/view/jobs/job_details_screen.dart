import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../res/app_url/app_url.dart';
import '../../res/colors/app_colors.dart';
import '../../view_models/controller/job_details_controller.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobDetailsController());
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Obx(() {
        final job = controller.request;
        if (controller.isLoading.value && job.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (job.isEmpty) return const Center(child: Text('Request not found'));
        final status = (job['status'] ?? '').toString();
        final category = (job['skill_category_name'] ?? 'Service').toString();
        final title = (job['sub_category'] ?? category).toString();
        final imageUrl = AppUrl.mediaUrl(job['image']?.toString());
        return Column(children: [
          Expanded(
            child: ListView(padding: EdgeInsets.zero, children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1B51E5), Color(0xFF2563EB), Color(0xFF3B82F6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
                ),
                padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                    ),
                    const Text('Job Details', style: TextStyle(
                      color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold,
                    )),
                  ]),
                  const SizedBox(height: 12),
                  Text(title, style: const TextStyle(
                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,
                  )),
                  const SizedBox(height: 5),
                  Text('$category • ${job['urgency'] ?? 'normal'}', style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 4),
                  Text('${job['request_id'] ?? ''} • $status', style: const TextStyle(color: Colors.white70)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _sectionTitle('REQUEST'),
                  const SizedBox(height: 8),
                  _card(child: Text((job['description'] ?? 'No description').toString())),
                  const SizedBox(height: 20),
                  _sectionTitle('LOCATION'),
                  const SizedBox(height: 8),
                  _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text((job['address'] ?? 'Address unavailable').toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text((job['city'] ?? '').toString()),
                    if (job['scheduled_at'] != null) ...[
                      const SizedBox(height: 8),
                      Text('Scheduled: ${job['scheduled_at']}'.replaceFirst('T', ' ')),
                    ],
                  ])),
                  const SizedBox(height: 20),
                  _sectionTitle('CUSTOMER PHOTO'),
                  const SizedBox(height: 8),
                  _card(child: imageUrl.isEmpty
                      ? const Center(child: Icon(Icons.image_not_supported_outlined, color: AppColor.primary, size: 36))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(
                            imageUrl,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stack) => const Icon(Icons.broken_image_outlined),
                          ),
                        )),
                  if (status == 'assigned' || status == 'in_progress') ...[
                    const SizedBox(height: 20),
                    _sectionTitle('JOB PHOTOS'),
                    const SizedBox(height: 8),
                    _card(child: Column(children: [
                      TextButton.icon(
                        onPressed: controller.isActionLoading.value ? null : () => _uploadPhoto(controller, 'photo_before'),
                        icon: const Icon(Icons.add_a_photo_outlined),
                        label: const Text('Upload before photo'),
                      ),
                      TextButton.icon(
                        onPressed: controller.isActionLoading.value ? null : () => _uploadPhoto(controller, 'photo_after'),
                        icon: const Icon(Icons.add_a_photo_outlined),
                        label: const Text('Upload after photo'),
                      ),
                    ])),
                  ],
                ]),
              ),
            ]),
          ),
          if (status == 'pending' || status == 'assigned' || status == 'in_progress')
            Container(
              padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
              color: Colors.white,
              child: Row(children: [
                if (status == 'pending') ...[
                  Expanded(child: OutlinedButton(
                    onPressed: controller.isActionLoading.value ? null : controller.rejectJob,
                    child: const Text('Reject'),
                  )),
                  const SizedBox(width: 12),
                  Expanded(child: ElevatedButton(
                    onPressed: controller.isActionLoading.value ? null : controller.acceptJob,
                    child: const Text('Accept Job'),
                  )),
                ] else
                  Expanded(child: ElevatedButton(
                    onPressed: controller.isActionLoading.value ? null : () => controller.updateStatus(
                      status == 'assigned' ? 'in_progress' : 'completed',
                    ),
                    child: Text(status == 'assigned' ? 'Start Job' : 'Complete Job'),
                  )),
              ]),
            ),
        ]);
      }),
    );
  }

  Widget _sectionTitle(String title) => Text(title, style: const TextStyle(
    fontSize: 12, fontWeight: FontWeight.bold, color: AppColor.textSecondary, letterSpacing: 0.8,
  ));

  Widget _card({required Widget child}) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColor.cardBackground,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColor.grey200.withValues(alpha: 0.6)),
      boxShadow: [BoxShadow(
        color: AppColor.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4),
      )],
    ),
    child: child,
  );

  Future<void> _uploadPhoto(JobDetailsController controller, String field) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    await controller.uploadPhotos({field: picked.path});
  }
}
