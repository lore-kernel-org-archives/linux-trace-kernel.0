Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408653;
	b=niFrf0bthoa9VOYdWpQEDZhjbZx2Hy8LBjw4oP4s5/2mj1fx4GV+GhbSX5zy1aFJXT2o
	 1AT036bScbbOzIRCLHXoGdUos1ETSP7yssds3QNZA+d7lPyYHcEsqkYzULtOA9spnrQAs
	 63Pydu2/9XCPiXDJvdzNtwO8B3YThUZ5UOKXf/8XDLfJ9F3UTh3XS2iqxqir2wD9n+j3E
	 Cy8SOtfE1mQaHKcJYAcnfV4IEonKAYTWwdG3EScR1rTSTHFzZYtOTPRAvr9WZQsj1OH2e
	 +jcxS73OO4MUQE87UPIqeMkv2SBtiqbEJ1HfnKfw34h7WtrVIfUcHygtB2nLyeqnPDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408653;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=in9PLro9lMFGv0mYwnCPKthhm5ByPZ39fDEfz6yqKgw=;
	b=TJ9FE2SCJkUbjUxjzgIxLzBJFuV56GoQnsGg9vkg1Ly2U0mR8mGgk163rX/LFVFQcejx
	 BDpFhNpBEXt1YGSMTsNBnqBscQnx+0HmJGp5NztYZxNqPqmPMXIQEYg4te5CqhXVmWzBd
	 EP2aX8hiwUhMZJuRSWFYqmq0FlwUIpFw36IJ19MG67Bymr81UZs54IfRAeFmRyQvhRr96
	 BSDMQ7x/MuEfuU9agrj3HRviCPW/CUpO5N0/x5EELMEugvpXTUnUieTptwIiz39rwKnNU
	 LfPr9UwqrzU6M+HYBEKTa+lkif7xlrNG60yj1G4bjCWNkIJs5yx/fptFPoPwTx4h5PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EnhWMxWB;
	arc=none smtp.remote-ip=91.218.175.66
Received: from mta0.migadu.com (out-66.mta0.migadu.com [91.218.175.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1F9606A330
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 14:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D1F9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EnhWMxWB
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7QlHaYu+LBh346BG07UqQIEHqd8tmQtc/kJLw6MKCas=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794408649; v=1; x=1795013449;
 b=EnhWMxWBnU720igFzLMyg8a1Aidzw9CtrNWxuRMeRaVrpF+XGvKmWrv5RHoq6reeXaehY0i1
 59qRI3VVC49Q8aWlJpMjBcoBg0YdyNJHZp6yQcnCgXJPldHuJy3Hdc/fICZc2fVelCn5T1DVsAd
 d9cya+1BaK+W2Tox76KNE+mU=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8bbdbe130a30bd31;
	Wed, 11 Nov 2026 14:50:49 +0000
X-Mizu-Trace-ID: 8bbdbe130a30bd31
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	dgilbert@interlog.com,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 0/2] blktrace: gate the blktrace interface behind CAP_SYS_ADMIN
Date: Wed, 11 Nov 2026 22:50:32 +0800
Message-ID: <20261111145034.248717-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

hello,

This series gates the blktrace interface behind CAP_SYS_ADMIN.
BLKTRACESETUP allocates user-sized relay buffers and sets up traces
that outlive the creating fd, but holding the block device node, an
sg node, or write access to the sysfs trace attributes is the only
requirement to drive that state today.  Split by tree so each patch
stays in one subsystem: patch 1 gates the block side (the ioctl
dispatch and the sysfs store) and documents the sysfs attributes,
patch 2 gates the sg passthrough.  The two are independent and can
be applied in any order; patch 1 should go through the block tree,
patch 2 needs a SCSI Ack (taking both through block with the Ack
works too).

Unprivileged callers get a single answer (-EPERM for the ioctls,
-EACCES for the sysfs store) instead of values that revealed whether
a trace existed and was running.  With CONFIG_BLK_DEV_IO_TRACE=n the
sg passthrough still returns -ENOTTY, as before.  Privileged callers
behave identically with and without the series.

Verified on next-20261104 under qemu: with the series applied,
BLKTRACESETUP with all capabilities dropped is rejected with -EPERM
through both /dev/sda and /dev/sg0, and a dropped-privilege write to
the sysfs enable attribute is rejected with -EACCES; without the
series the unprivileged ioctl and the sysfs write both succeed.

Base: next-20261104.

Changes since v1:
 - also gate the sysfs trace attribute group, which reached the same
   tracing state without any check (found in follow-up review)
 - document the sysfs trace group in Documentation/ABI, where it has
   been missing since 2009
 - gate the sg passthrough commands in a new patch; the v1 commit
   message mentioned the sg path but gated only blk_trace_ioctl()
   (flagged by sashiko's review of the first posting)
 - commit messages now claim only what each patch covers

Link: https://lore.kernel.org/all/20261106142852.3233950-1-cui.tao@linux.dev/

Tao Cui (2):
  blktrace: require CAP_SYS_ADMIN for the blktrace interface
  scsi: sg: Require CAP_SYS_ADMIN for BLKTRACE passthrough ioctls

 Documentation/ABI/stable/sysfs-block | 18 ++++++++++++++++++
 drivers/scsi/sg.c                    | 10 ++++++++++
 kernel/trace/blktrace.c              |  6 ++++++
 3 files changed, 34 insertions(+)

-- 
2.53.0

