Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.77.101.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795248816;
	b=Kq+efSxsMQE7zPrDy/6o49VWUZnXo6iGZLLH/7HSD0hgU5RBVDWzrJ2eBMF/OhXiAChe
	 ZDjQ6f5gTtbCyZMdvc6hS/fuJikkQ8YYKBWvdmrsghNLtP6UzlJqVFGrT+0z37mCz6UZo
	 C8cJhhXy/OXmMpA7IZjVZMmfkvriza+efAe3kbnASv2e7rFZSJy3FmciiLo2Zrm1L2c9V
	 NlI14dRCN/6bEOKeuawgq0xCa01uN5l5NmfAm+P8M/RiNUPjwRnt/7mYFxtsJjK+JoM8L
	 er7IDMyp4VL9PsVbO85ZCjs08oC3UBMqmdVTMxDOjSohuGMoECc34rxHxVMPeuOhl5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795248816;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-WP-MailID:X-WP-AV:X-WP-SPAM;
	bh=VCAf6mQ3Fl2AXCxBuPjWpObFsYWR0l3vlQX61gKFzsY=;
	b=lOrREg7nz5ZtZJAMC37OwyZyRoRVsdxYap+Klp/80VdfT/SGGtp2Q3udb/My8BK8KfOn
	 ObLy09Zjs1UyPP708dBc/xOupA+Xn3AHDbI1+nKq1fO42oW4rACUu9z9Eppn12H3FkAQD
	 QkLdT5HaldqY9UdiAFqPzOOul2QOjDZeV1zptceQIOMCd/oMYRgNn4GCBtomn4CfPw4kR
	 BH4T2pvV+KZDsZ1ZOnLw3iBWCmzNKNo3g4LK3yaggE3Kl3OVLl1pJGAOp+rDvpl2TQdfp
	 9YSOqd0M2oePJdUJyzcJiOIXktpjcPtg288wB0RR6n36wjpdHD+y8/cXlodxSaEuDvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wp.pl;
	spf=pass smtp.mailfrom=wp.pl;
	dkim=pass header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=HwrMwpic;
	arc=none smtp.remote-ip=212.77.101.9
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F7606A320
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 08:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C02F7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=HwrMwpic
Received: (wp-smtpd smtp.wp.pl 35891 invoked from network); 21 Nov 2026 09:13:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=s20261001;
          t=1795248804; bh=VCAf6mQ3Fl2AXCxBuPjWpObFsYWR0l3vlQX61gKFzsY=;
          h=From:To:Cc:Subject;
          b=HwrMwpiceZkYmzcQXq8hrrt6UMdviEezRgpHHrNgRerhZ2Qyapr4L6q37rEEQBbQ1
           6b288xzm7lgQL0ClOWac/2aW6Tvi/YDvDEURiS6RoG+ceFfnJvu//YM3xOPdrKrcPO
           pMKHno468qwBNrYkC2y9G9e7KKDIK9h21UZJ3L9R3RCBNpY1wCHauhJrAOPbvHWiVJ
           WWKlrUjTd238WwWtyoOj2WPAMUuMf9F5b5J3L7RJAgnRML4ca+gES0igGUrU/BPBYo
           XQCHRxJBoMzGf7YoFJbpiF1lApMZYUlMiOIpr29/FAXRURu+OKE1KLCQn+nz/7bvmh
           n6wHbdSgJ4uVA==
Received: from localhost (77-236-5-223.static.play.pl [77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <deduce@gmail.com>; 21 Nov 2026 09:13:24 +0100
Date: Sat, 21 Nov 2026 09:13:24 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Lawrence Lin <deduce@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Petr Pavlu <petr.pavlu@suse.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Avoid quadratic symbol lookups in
 ftrace_module_enable()
Message-ID: <awFSpF86nx3t1g07@wp.pl>
References: <20261003-ftrace-mod-bsearch-v1-1-92e2fd2d80ff@gmail.com>
 <20261004050904.06a5ecab@fedora>
 <20261004170600.1541723-1-deduce@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004170600.1541723-1-deduce@gmail.com>
X-WP-MailID: b6f216805e4b1c6aceebbf956d6fa592
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [cQOU]                               

On Sun, Oct 04, 2026 at 12:05:58PM -0500, Lawrence Lin wrote:
> On Sun, 4 Oct 2026 05:09:04 -0400, Steven Rostedt wrote:
> > It would be interesting if it actually triggers (finds something). If
> > it doesn't, then I think we should just remove that code instead of
> > adding more complexity to it.
> 
> It does trigger, but only for modules. On x86_64 v7.2.5 with kvm loaded,
> available_filter_functions has 18 __ftrace_invalid_address___ entries,
> all of them in [kvm] and none in vmlinux. Each one is a __weak default
> from virt/kvm/ (kvm_arch_vm_compat_ioctl, kvm_arch_shutdown,
> kvm_arch_dy_runnable, ...) that arch/x86/kvm/ overrides inside the same
> kvm.ko. In kvm.ko, no symbol covers any of the 18 addresses, and each
> body is a stub that returns, returns a constant, or tail calls.
> 
> ef378c3b823385 fixed this for vmlinux at build time, but sorttable only
> runs on vmlinux, so modules still depend on the check. In its changelog
> you wrote that "the real solution is to not add a weak function into
> the ftrace table in the first place". For modules, that can be done at
> load time, and it would make this patch much smaller.

I think the best way to handle this would be to simply mark weak
functions as notrace. While this is considered a hack that we cannot
rely on [1], it should still be acceptable for modules.

As a safeguard, __weak can remain undefined for modules, and checkpatch
already warns about __atribute__((weak)). This should prevent any new
traceable weak functions from being added to modules.

The change is relatively small and prevents introducing additional
complexity at either build time or module load time. The full patch is
below (without removing ftrace test_for_valid_rec()).

The list of weak functions in modules was generated with the help of AI.
If missed any, hopefully the kernel test robot (Inel 0-day CI) will catch
the resulting build failures once the patch is posted.

[1] https://lore.kernel.org/all/CAADnVQKi+4oBt2C__qz7QoHqTtXYLUjaqwTNFoSE=up9c9k4cA@mail.gmail.com/

Regards
Stanislaw

 drivers/acpi/nfit/core.c                                 |    2 +-
 drivers/acpi/processor_driver.c                          |    2 +-
 drivers/acpi/processor_idle.c                            |    4 ++--
 drivers/dax/bus.c                                        |    4 ++--
 drivers/firmware/efi/capsule-loader.c                    |    4 ++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c |    2 +-
 drivers/nvdimm/pmem.c                                    |    6 +++---
 drivers/virtio/virtio_rtc_ptp.c                          |    2 +-
 include/linux/compiler_attributes.h                      |    6 ------
 include/linux/compiler_types.h                           |   13 +++++++++++++
 virt/kvm/dirty_ring.c                                    |    2 +-
 virt/kvm/eventfd.c                                       |   24 ++++++++++--------------
 virt/kvm/guest_memfd.c                                   |    2 +-
 virt/kvm/irqchip.c                                       |    2 +-
 virt/kvm/kvm_main.c                                      |   29 +++++++++++++----------------
 15 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 476c4c560d17..d716f7c2978b 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -416,12 +416,6 @@
 # define __noipa
 #endif
 
-/*
- *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
- *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
- */
-#define __weak                          __attribute__((__weak__))
-
 /*
  * Used by functions that use '__builtin_return_address'. These function
  * don't want to be splited or made inline, which can make
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..33f0623befa5 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -217,6 +217,19 @@ struct ftrace_likely_data {
 #define notrace			__attribute__((__no_instrument_function__))
 #endif
 
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
+ */
+#ifdef MODULE
+#define __weak_func		__attribute__((__weak__)) notrace
+#else
+#define __weak_func		__attribute__((__weak__))
+#define __weak			__attribute__((__weak__))
+#endif
+
+#define __weak_data		__attribute__((__weak__))
+
 /*
  * it doesn't make sense on ARM (currently the only user of __naked)
  * to trace naked functions because then mcount is called without
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index cb771d9cadb2..9a8f63ab3997 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1733,7 +1733,7 @@ static bool acpi_nvdimm_has_method(struct acpi_device *adev, char *method)
 	return false;
 }
 
-__weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
+__weak_func void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
 {
 	struct device *dev = &nfit_mem->adev->dev;
 	struct nd_intel_smart smart = { 0 };
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index bdd1529d79f0..b6494c6bba7e 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -230,7 +230,7 @@ static struct notifier_block acpi_processor_notifier_block = {
 	.notifier_call = acpi_processor_notifier,
 };
 
-void __weak acpi_processor_init_invariance_cppc(void)
+__weak_func void acpi_processor_init_invariance_cppc(void)
 { }
 
 /*
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e113bcbbb882..8b5d37bd8955 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -853,7 +853,7 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 
 #endif /* CONFIG_ACPI_PROCESSOR_CSTATE */
 
-int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
+int __weak_func acpi_processor_ffh_lpi_probe(unsigned int cpu)
 {
 	return -EOPNOTSUPP;
 }
@@ -878,7 +878,7 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	return 0;
 }
 
-int __weak __cpuidle acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
+int __weak_func __cpuidle acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 {
 	return -ENODEV;
 }
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index b809e1a264af..9bf8fc9ab61c 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1430,8 +1430,8 @@ static const struct device_type dev_dax_type = {
 };
 
 /* see "strong" declaration in tools/testing/nvdimm/dax-dev.c */
-__weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
-			      unsigned long size)
+__weak_func phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
+					  unsigned long size)
 {
 	for (int i = 0; i < dev_dax->nr_range; i++) {
 		struct dev_dax_range *dax_range = &dev_dax->ranges[i];
diff --git a/drivers/firmware/efi/capsule-loader.c b/drivers/firmware/efi/capsule-loader.c
index 8e8f81f0a5a0..e28c9cc28917 100644
--- a/drivers/firmware/efi/capsule-loader.c
+++ b/drivers/firmware/efi/capsule-loader.c
@@ -88,8 +88,8 @@ int __efi_capsule_setup_info(struct capsule_info *cap_info)
  * this __weak function so they can perform any required capsule
  * image munging. See quark_quirk_function() for an example.
  **/
-int __weak efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
-				  size_t hdr_bytes)
+int __weak_func efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
+				       size_t hdr_bytes)
 {
 	/* Only process data block that is larger than efi header size */
 	if (hdr_bytes < sizeof(efi_capsule_header_t))
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 4e418c7456b7..95c2b770cdbe 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -2094,7 +2094,7 @@ int otx2_set_hw_capabilities(struct otx2_nic *pfvf)
 }
 
 #define M(_name, _id, _fn_name, _req_type, _rsp_type)			\
-int __weak								\
+int __weak_func								\
 otx2_mbox_up_handler_ ## _fn_name(struct otx2_nic *pfvf,		\
 				struct _req_type *req,			\
 				struct _rsp_type *rsp)			\
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 30a51c365ce8..e8564000cff0 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -254,9 +254,9 @@ static void pmem_submit_bio(struct bio *bio)
 }
 
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
-__weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
-		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		unsigned long *pfn)
+__weak_func long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
+				      long nr_pages, enum dax_access_mode mode, void **kaddr,
+				      unsigned long *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 	sector_t sector = PFN_PHYS(pgoff) >> SECTOR_SHIFT;
diff --git a/drivers/virtio/virtio_rtc_ptp.c b/drivers/virtio/virtio_rtc_ptp.c
index ff8d834493dc..b93d86dd8c86 100644
--- a/drivers/virtio/virtio_rtc_ptp.c
+++ b/drivers/virtio/virtio_rtc_ptp.c
@@ -48,7 +48,7 @@ struct viortc_ptp_cross_ctx {
 };
 
 /* Weak function in case get_device_system_crosststamp() is not supported */
-int __weak viortc_hw_xtstamp_params(u8 *hw_counter, enum clocksource_ids *cs_id)
+int __weak_func viortc_hw_xtstamp_params(u8 *hw_counter, enum clocksource_ids *cs_id)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index 572b854edf74..74979851fb5c 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -11,7 +11,7 @@
 #include <trace/events/kvm.h>
 #include "kvm_mm.h"
 
-int __weak kvm_cpu_dirty_log_size(struct kvm *kvm)
+int __weak_func kvm_cpu_dirty_log_size(struct kvm *kvm)
 {
 	return 0;
 }
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 93ad2ebc963f..95db366e6804 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -33,8 +33,7 @@
 
 static struct workqueue_struct *irqfd_cleanup_wq;
 
-bool __attribute__((weak))
-kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args)
+bool __weak_func kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args)
 {
 	return true;
 }
@@ -187,11 +186,9 @@ static void irqfd_deactivate(struct kvm_kernel_irqfd *irqfd)
 	queue_work(irqfd_cleanup_wq, &irqfd->shutdown);
 }
 
-int __attribute__((weak)) kvm_arch_set_irq_inatomic(
-				struct kvm_kernel_irq_routing_entry *irq,
-				struct kvm *kvm, int irq_source_id,
-				int level,
-				bool line_status)
+int __weak_func kvm_arch_set_irq_inatomic(
+	struct kvm_kernel_irq_routing_entry *irq, struct kvm *kvm,
+	int irq_source_id, int level, bool line_status)
 {
 	return -EWOULDBLOCK;
 }
@@ -349,19 +346,18 @@ static void kvm_irqfd_register(struct file *file, wait_queue_head_t *wqh,
 }
 
 #if IS_ENABLED(CONFIG_HAVE_KVM_IRQ_BYPASS)
-void __attribute__((weak)) kvm_arch_irq_bypass_stop(
-				struct irq_bypass_consumer *cons)
+void __weak_func kvm_arch_irq_bypass_stop(struct irq_bypass_consumer *cons)
 {
 }
 
-void __attribute__((weak)) kvm_arch_irq_bypass_start(
-				struct irq_bypass_consumer *cons)
+void __weak_func kvm_arch_irq_bypass_start(struct irq_bypass_consumer *cons)
 {
 }
 
-void __weak kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
-					  struct kvm_kernel_irq_routing_entry *old,
-					  struct kvm_kernel_irq_routing_entry *new)
+void __weak_func
+kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
+			      struct kvm_kernel_irq_routing_entry *old,
+			      struct kvm_kernel_irq_routing_entry *new)
 {
 
 }
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 5c084d5393a6..ed49d2f59cf3 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -515,7 +515,7 @@ static const struct inode_operations kvm_gmem_iops = {
 	.setattr	= kvm_gmem_setattr,
 };
 
-bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
+bool __weak_func kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 {
 	return true;
 }
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 462c70621247..4e521bf3f4a3 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -160,7 +160,7 @@ void __attribute__((weak)) kvm_arch_irq_routing_update(struct kvm *kvm)
 {
 }
 
-bool __weak kvm_arch_can_set_irq_routing(struct kvm *kvm)
+__weak_func bool kvm_arch_can_set_irq_routing(struct kvm *kvm)
 {
 	return true;
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5a782849521c..d3a5c0918029 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -155,7 +155,7 @@ static unsigned long long kvm_active_vms;
 
 static DEFINE_PER_CPU(cpumask_var_t, cpu_kick_mask);
 
-__weak void kvm_arch_guest_memory_reclaimed(struct kvm *kvm)
+__weak_func void kvm_arch_guest_memory_reclaimed(struct kvm *kvm)
 {
 }
 
@@ -1071,7 +1071,7 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, const char *fdname)
  * Called just after removing the VM from the vm_list, but before doing any
  * other destruction.
  */
-void __weak kvm_arch_pre_destroy_vm(struct kvm *kvm)
+void __weak_func kvm_arch_pre_destroy_vm(struct kvm *kvm)
 {
 }
 
@@ -1081,7 +1081,7 @@ void __weak kvm_arch_pre_destroy_vm(struct kvm *kvm)
  * Cleanup should be automatic done in kvm_destroy_vm_debugfs() recursively, so
  * a per-arch destroy interface is not needed.
  */
-void __weak kvm_arch_create_vm_debugfs(struct kvm *kvm)
+void __weak_func kvm_arch_create_vm_debugfs(struct kvm *kvm)
 {
 }
 
@@ -3955,7 +3955,7 @@ static bool kvm_vcpu_eligible_for_directed_yield(struct kvm_vcpu *vcpu)
  * a vcpu_load/vcpu_put pair.  However, for most architectures
  * kvm_arch_vcpu_runnable does not require vcpu_load.
  */
-bool __weak kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)
+bool __weak_func kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)
 {
 	return kvm_arch_vcpu_runnable(vcpu);
 }
@@ -3980,12 +3980,12 @@ static bool vcpu_dy_runnable(struct kvm_vcpu *vcpu)
  * mode even if the vCPU is NOT loaded, i.e. using kvm_arch_vcpu_in_kernel()
  * directly for cross-vCPU checks is functionally correct and accurate.
  */
-bool __weak kvm_arch_vcpu_preempted_in_kernel(struct kvm_vcpu *vcpu)
+bool __weak_func kvm_arch_vcpu_preempted_in_kernel(struct kvm_vcpu *vcpu)
 {
 	return kvm_arch_vcpu_in_kernel(vcpu);
 }
 
-bool __weak kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
+bool __weak_func kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
 {
 	return false;
 }
@@ -5030,8 +5030,8 @@ static int kvm_vm_ioctl_reset_dirty_pages(struct kvm *kvm)
 	return cleared;
 }
 
-int __attribute__((weak)) kvm_vm_ioctl_enable_cap(struct kvm *kvm,
-						  struct kvm_enable_cap *cap)
+int __weak_func kvm_vm_ioctl_enable_cap(struct kvm *kvm,
+					struct kvm_enable_cap *cap)
 {
 	return -EINVAL;
 }
@@ -5433,8 +5433,8 @@ struct compat_kvm_clear_dirty_log {
 	};
 };
 
-long __weak kvm_arch_vm_compat_ioctl(struct file *filp, unsigned int ioctl,
-				     unsigned long arg)
+long __weak_func kvm_arch_vm_compat_ioctl(struct file *filp, unsigned int ioctl,
+					  unsigned long arg)
 {
 	return -ENOTTY;
 }
@@ -5605,19 +5605,16 @@ static DEFINE_PER_CPU(bool, virtualization_enabled);
 static DEFINE_MUTEX(kvm_usage_lock);
 static int kvm_usage_count;
 
-__weak void kvm_arch_shutdown(void)
+__weak_func void kvm_arch_shutdown(void)
 {
-
 }
 
-__weak void kvm_arch_enable_virtualization(void)
+__weak_func void kvm_arch_enable_virtualization(void)
 {
-
 }
 
-__weak void kvm_arch_disable_virtualization(void)
+__weak_func void kvm_arch_disable_virtualization(void)
 {
-
 }
 
 static int kvm_enable_virtualization_cpu(void)
