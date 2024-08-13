Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE233D38E;
	Tue, 13 Aug 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569165; cv=none; b=Q6dwC7MbDY9ND5dE7vliIJ9XTdkTUF99VqF1v8PP+tdPa2JPEwlgPr2dpCwt2iaiY4QN9nR5cukKn+TJaRzdXqrxX2lwKCBp1QjUh6WiV8FZIZaWxp53mhw8/2NC4KzAF+kRqvXecrBCOCdGogFtBFcx5CONABHKvlw+mhH6K/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569165; c=relaxed/simple;
	bh=LCqfXSkkEPSeZ1kiAFPjShQDR+HMV48XK4nlBDvBQ3U=;
	h=Message-ID:Date:From:To:Cc:Subject; b=OW73Ikzd7HjU4VPgMm0ILVcJkXm62jgaJfJ74tq1rq5rvDtiFpBgjxO6v4oaKUpQQekYtQVESCP8412yuG/tSss9NPMlk+u4Cps0LsSr7oUxzd2Lf8AQ5CcpAQRvD3qbNuupHa1wVN/gltP5uMjd3SLRBhkxTqE97Tt17jcETn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F6EC4AF09;
	Tue, 13 Aug 2024 17:12:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sdv4r-00000001TP3-1E3J;
	Tue, 13 Aug 2024 13:12:57 -0400
Message-ID: <20240813171104.950972475@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 13 Aug 2024 13:11:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ross Zwisler <zwisler@google.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH 0/2] tracing: Have boot instance use reserve_mem option and use fgraph tracer
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Now that "reserve_mem" kernel command line option is upstream, add a patch
to use it with the ring buffer boot up mappings. That is:

  reserve_mem=12M:4096:trace trace_instance=boot_mapped@trace

Will allocate 12 megabytes at boot up that is aligned by 4096 bytes and
label it with "trace". A trace_instance with the name "boot_mapped" will be
created on top of that memory.

Documentation has been updated about this and it states that KASLR can make
it somewhat unreliable for every boot as well as the layout of the memory
for the ring buffer may change with new kernel versions which will clear the
previous buffer.

Also, now that function graph tracing can be used by trace instances,
update its code to be able to be used by this boot process. This can give a
nicer trace of a reboot:

           swapper/0-1       [000] d..1.   363.079162:  0)               |              lapic_shutdown() {
           swapper/0-1       [000] d..1.   363.079163:  0)               |                disable_local_APIC() {
           swapper/0-1       [000] d..1.   363.079163:  0) + 26.144 us   |                  clear_local_APIC.part.0();
           swapper/0-1       [000] d....   363.079192:  0) + 29.424 us   |                }
           swapper/0-1       [000] d....   363.079192:  0) + 30.376 us   |              }
           swapper/0-1       [000] d..1.   363.079193:  0)               |              restore_boot_irq_mode() {
           swapper/0-1       [000] d..1.   363.079194:  0)               |                native_restore_boot_irq_mode() {
           swapper/0-1       [000] d..1.   363.079194:  0) + 13.863 us   |                  disconnect_bsp_APIC();
           swapper/0-1       [000] d....   363.079209:  0) + 14.933 us   |                }
           swapper/0-1       [000] d....   363.079209:  0) + 16.009 us   |              }
           swapper/0-1       [000] d..1.   363.079210:  0)   0.694 us    |              hpet_disable();
           swapper/0-1       [000] d..1.   363.079211:  0)   0.511 us    |              iommu_shutdown_noop();
           swapper/0-1       [000] d....   363.079212:  0) # 3980.260 us |            }
           swapper/0-1       [000] d..1.   363.079212:  0)               |            native_machine_emergency_restart() {
           swapper/0-1       [000] d..1.   363.079213:  0)   0.495 us    |              tboot_shutdown();
           swapper/0-1       [000] d..1.   363.079230:  0)               |              acpi_reboot() {
           swapper/0-1       [000] d..1.   363.079231:  0)               |                acpi_reset() {
           swapper/0-1       [000] d..1.   363.079232:  0)               |                  acpi_os_write_port() {

This is based on top of:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
     branch: ring-buffer/for-next

Which was supposed to go in the last merge window, but due to
miscommunication, it did not. As it has been in linux-next, I do not want to
rebase it, so instead I merged in v6.11-rc1 to get access to the
reserve_mem kernel command line parameter and applied these patches on top.


Steven Rostedt (1):
      tracing/fgraph: Have fgraph handle previous boot function addresses

Steven Rostedt (Google) (1):
      tracing: Allow boot instances to use reserve_mem boot memory

----
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
 kernel/trace/trace.c                            | 19 +++++++++++++------
 kernel/trace/trace_functions_graph.c            | 23 ++++++++++++++++++-----
 3 files changed, 44 insertions(+), 11 deletions(-)
