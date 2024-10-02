Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE73333D1;
	Wed,  2 Oct 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885338; cv=none; b=VX/WD6UPt/07etmu0p1JbR6rDgRsOOM2EBv0mxQRYjrf6MS1lDMOTxPrqVEubiyauvMA7QEiEpYr/vSKHmuDIYRiE/H/bvIZA7X0AEJ41PT2PfUPlMnHHqahk+M+AhGXR0qoXK/zLu70+tbzmDWoBFoid4YzYcw/4Dnm2uSrwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885338; c=relaxed/simple;
	bh=pdY1ptD0wps62N0pwzF1uZbCtci9WImvSG+ABS99HVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M6ZnS2qxD6PFrwQsVC3b4k4wQJe1EYkaXIBHqm9wbxI9tMGLT0uExDOOYdrd40PhCUIUvtBI7ePiDC1cXYMO7yvw6uxf+BdyMEAQcVWFrda/fxRdwNTgt+BqfZMyQxUEaFcOUkaxvYOn3+A/bULwaNqkgTbIvadaGp/WrikATos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=Qco0Cr8s; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="Qco0Cr8s"
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4084E60A53;
	Wed,  2 Oct 2024 19:08:50 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Z8emWD2IhiE0-AzWbIPI5;
	Wed, 02 Oct 2024 19:08:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1727885329;
	bh=Qu8AzV4vrubALdhHGWYjkmRujMkHXpB9Tz28NNmsJNU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Qco0Cr8sVJxDco/+vtwTXI7KiXbCi2ZO0WM08Z3X3KzHc88CYxfKbsa3MZ/jjFFb/
	 1PQigYr31xemiZ5awWpcOa2tnMclwk+CdFMbl+M3UpNVx724+Z+jc4UzW5Y7jhxvth
	 3gRidhfUKoCKDvOe5CABTSfbPFVO75C2umbWyYBM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	valesini@yandex-team.com,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [RFC PATCH 0/7] KSTATE: a mechanism to migrate some part of the kernel state across kexec
Date: Wed,  2 Oct 2024 18:07:15 +0200
Message-ID: <20241002160722.20025-1-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

kstate (kernel state) is a mechanism to describe internal some part of the
kernel state, save it into the memory and restore the state after kexec
in the new kernel.

This is a very early RFC with a lot of hacks and cut corners with
the purpose to demonstrate the concept itself. Some parts
of this feature isn't well thought trough yet (like dealing with
struct changes between old and new kernel, fixed size of migrate stream
memory and absence of boundary checks, and so on and on).

The end goal here and the main use case for this is to be able to
update host kernel under VMs with VFIO pass-through devices running
on that host.
We are pretty far from that end goal yet. This patchset only tries
to establish some basic infrastructure to describe and migrate complex
in-kernel states.

The inspiration for this came from QEMU and its VMSTATE stuff which
is used to solve similar problem - migrate complex internal state
across different versions of QEMU. So there is a bit of similarity here.

The alternative for the kstate is KHO (Kexec Hand Over) [1].
Since in KHO migrates trace buffers, I decided to choose them
as a victim for kstate too. So we can compare both approaches.

In my very biased opinion with kstate it's much easier to describe
some state to migrate it to new kernel. And seems requires
almost none intervention into existing code paths of the subsystem.icated


So now to the part how this works.

States (usually this is some struct) are described by the
'struct kstate_description' containing the array of individual
fields descpriptions - 'struct kstate_field'.
Fields have different types like:
   KS_SIMPLE  - trivial type that just copied by value

   KS_POINTER - field contains pointer, it will be dereferenced to copy
     the value during save/restore phases.

   KS_STRUCT - contains another struct,
       field->ksd must point to another 'struct kstate_dscription'

   KS_CUSTOM - something that requires fit trivial types as above,
               for this fields the callbacks field->save()/->restore() must
	       do all job
   KS_ARRAY_OF_POINTER - array of pointers, the size of array determined by the
                         field->count() callback
   KS_END - special flag indicating the end of migration stream data.


kstate_register() call accepts kstate_description along with an instance
of an object and registers it in the global 'states' list.

During kexec reboot phase this list iterated, and for each instance
in the list 'struct kstate_entry' formed and saved in the migration stream.
'kstate_entry' contains information like ID of kstate_description, version
of it, size of migration data and the data itself.

After the reboot, when the kstate_register() called it parses migration
stream, finds the appropriate 'kstate_entry' and restores the contents of the
object.

The content of this patchset:

The first patch contains the most of the basic KSTATE infrastructure.

The 2,3 patches are temporary hacks needed to pass the memory used to store
migration data across kexec. Will be completely redone later.

The 4,5 patches are bits needed to preserve pages intact across kexec.

6 is test&playground patch to develop and test kstate itself.

7 is a demonstration of how to migrate trace buffer using kstate.


[1] https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com/

Andrey Ryabinin (7):
  kstate: Add kstate - a mechanism to migrate some kernel state across
    kexec
  kexec: Hack and abuse crashkernel for the kstate's migration stream
  [hack] purgatory: disable purgatory verification.
  mm/memblock: Add MEMBLOCK_PRSRV flag
  kstate: Add mechanism to preserved specified memory pages across
    kexec.
  kstate, test: add test module for testing kstate subsystem.
  trace: migrate trace buffers across kexec

 arch/x86/kernel/kexec-bzimage64.c  |  36 +++++
 arch/x86/kernel/machine_kexec_64.c |   5 +-
 arch/x86/kernel/setup.c            |  81 ++++++++++++
 arch/x86/purgatory/purgatory.c     |   2 +
 include/linux/kexec.h              |   6 +-
 include/linux/kstate.h             | 129 ++++++++++++++++++
 include/linux/memblock.h           |   7 +
 include/uapi/linux/kexec.h         |   2 +
 kernel/Kconfig.kexec               |  12 ++
 kernel/Makefile                    |   1 +
 kernel/crash_core.c                |   3 +-
 kernel/kexec_core.c                |  10 +-
 kernel/kexec_file.c                |  15 ++-
 kernel/kstate.c                    | 205 +++++++++++++++++++++++++++++
 kernel/trace/ring_buffer.c         | 189 ++++++++++++++++++++++++++
 kernel/trace/trace.c               |  81 ++++++++++++
 lib/Makefile                       |   2 +
 lib/test_kstate.c                  |  89 +++++++++++++
 mm/memblock.c                      |   9 +-
 mm/mm_init.c                       |  19 +++
 20 files changed, 895 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/kstate.h
 create mode 100644 kernel/kstate.c
 create mode 100644 lib/test_kstate.c

-- 
2.45.2

