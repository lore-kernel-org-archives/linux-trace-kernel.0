Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17813B2FC2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715720; cv=none; b=u1Z8kmZmsWV06l6UTDxMAEzIup1lSS3yZf/sE59eOZ7lxeKac1CY6wR8rLnr/YS3J6RdgQkI0Ch4jqdpF9EM0pk/+zGhyDArOobf4qm84vg2dKsuHSM1MG0UPN+A9wDRk3L7Hqo7URIbWXifpT6nbNhepG/dO5s1uKPBkmq6RK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715720; c=relaxed/simple;
	bh=3TnaohRSjA7u9kb0fvpr5atPg05ZZyGnSCboe6EyYNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cojKFFzh/PDzGd9IrpelVh3rYUPoHsnk0ta+hY878A01U1dlT/o5/XMD7BuqAPPcJ4BM9UDcqYYUejESTHxQpMmI3MLG1FqVHLu9smy5uz8+JM2fxc9OaRfF6ob44Y+9fkECfjYkPNAyfkheKyZsndCn6XUgDawyIazMDHyZzuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTLKQ2IC; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTLKQ2IC"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24afso307969a91.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789715712; x=1790320512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Bkp/RFC9ZZAGi4GjN9yJHrX67uXW3aJJkkSzqSHpAE=;
        b=HTLKQ2IC1KMJpdMOAPV1TwnIIgH2e6utCS/VXMoNg/mhELjZIIuMrusdi0Wvz6h8ya
         8dKTd/jca5YY1LbGrIVxNrELE/sxIlxaOFD2uWaPqsbN3HklVDVhkoE01F9aBJhsCRXt
         EMeAJIPrZKSYu/ZDl8AR0SvSsWlArt9ZEHPHsozg4PfOnBG1Ca0sHBKNMg5SYtvd/XJw
         m34BOSLkBaXEDHOeLrLS4+UWNWv8KSwDF4tUBC7+kIJ3Onl5Le28IHRrugm6f+t4qXRp
         IF4Ky4pq/4FG/bH5107fHt51vEK4X1vskFUpE6ZNOiApyZuTH38pmhiJalCslf96RMG2
         tzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789715712; x=1790320512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Bkp/RFC9ZZAGi4GjN9yJHrX67uXW3aJJkkSzqSHpAE=;
        b=0DPk2WnEo0LcRdm9YvYYsdPBmR5Inmj3hto7FrftKSxYPnFlffglWjx73XKsDElPZS
         v8UwPugNCJpE21u+mhGLJVDEFsglsyshMMnqGemVtmxoBU0DkS7IIKlBg67OGayGnlbi
         KQJ7CVD0LZHIWGk02a7GKMj0SGGDDL0adhbLAIM6kVAe9ez1NgXDjH9RQiDmvhdiQQf3
         GqsaNpQFZsWaVYR3v8kSrJuzz75gSibGsqSbtu4KezAlwELbk7dyPOQKqcIsKt4YRE3q
         41wdsbBzCrkkLg556DN4FfWn8If7EpfBvwGnsNNtvafRd+eycOCMFtSGZN40tXV7LJbi
         DGHw==
X-Forwarded-Encrypted: i=1; AKwUvBy4a5BBIp1V4FFvnpffYcOP5FBySXzioNRjkGgTJ+2KwM0snPj6rLjDjS88yiK0rLpUZTHs9ThM+2g3dKptkAM3jdM=@vger.kernel.org
X-Gm-Message-State: AFuF++nl2S0nwTKNtc3b8u1tcKXLHoHX4CGycnLqgTW0Hka83jbyTuER
	GawHFCLTaYIw4Te4+ZGAiCfaOj8f+t3UA7OrTWq9wHCtaBKNxouu2P0=
X-Gm-Gg: AYBFou3Vs5eOci3TEmhb4m2IUjIIbZxEQnLrMU0QQdSAgS5JNvUq0OoUHaLtsL+XxFh
	YHt/2hHKyu9QhMCG/ROSpz1POGrNnCedaaastac/KG6D6wlhsjyHjbaHxre9vHZNGNWuSDLJD/9
	MeQBhINhNa/J7X1TkAsCDlYrQwwrh2nuV21YQcDNMH1ngWq7Zmqx5wigYPb94AKvKFaUpqpzlYr
	XCdYzmrXMwAAqUVLrv501LbsVEmGIPlHhvHUj+eEHvNDI9OAMLaanzp7lyV9meAA7VmzeO6scdE
	yeqkqzFahiS/Xgk1AtAfyFvA+v8sSOJFg8hgf5BJrTTs40r7JR39acRYSJYkumU9PyQE061jZQO
	chnDNnEYZf4mvBB2fiJGEj3c/UYOnmeG+4GkvCWm4OQn0UBUwvGSla4zS7IoXERzYwvkkPZvQA9
	M7KAAhZ65GFp1JQ7or7FO/HavhQGfQuHF+oJxKYNi5K/FCzJuoEFva6cTLxO3C00odOdVsBkX90
	b6DHjwlN9y4NdNjlUmhPbvp6Ac=
X-Received: by 2002:a17:90b:538d:b0:39d:ef3e:9035 with SMTP id 98e67ed59e1d1-39e54e3c190mr6935740a91.10.1789715712538;
        Fri, 18 Sep 2026 00:15:12 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:d047:17af:bfc7:1a9a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36170735sm8842180a91.8.2026.09.18.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 00:15:12 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v1] ring-buffer: Fix the sub-buffer array base in rb_meta_subbuf_idx()
Date: Fri, 18 Sep 2026 16:15:07 +0900
Message-ID: <20260918071507.1019251-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a persistent ring buffer, rb_meta_subbuf_idx() can return an index one
sub-buffer too high.  rb_setup_ids_meta_page() then fills subbuf_ids[]
shifted by one and leaves subbuf_ids[0] NULL, which __rb_map_vma()
dereferences when userspace maps trace_pipe_raw.  rb_update_meta_reader()
writes two such indices into meta->buffers[], which rb_cpu_meta_valid()
would reject on the next boot, discarding the previous boot's trace.

A CPU's sub-buffer array starts after its meta header and the nr_subbufs
integers that follow, aligned up to a sub-buffer.  rb_meta_subbuf_idx()
inverts that calculation but skips only the integers, not the header, so
its base is one sub-buffer low whenever the omitted header size crosses
the alignment boundary.

Invert the calculation with rb_subbufs_from_meta() rather than repeating
it.  rb_range_buffer() maps an index back to an address through the same
helper, so the two directions can no longer disagree.

Cc: <stable@vger.kernel.org>
Fixes: b14d032973d4 ("ring-buffer: Add ring_buffer_meta data")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
x86_64_defconfig plus KASAN, FTRACE, TRACING and TRACER_SNAPSHOT, on
5dd1818b15d9, booted with reserve_mem=<size>:0x1000:trace
trace_instance=boot_mapped@trace.  head_buffer is from
instances/boot_mapped/per_cpu/cpuN/buffer_meta, the map of that CPU's
trace_pipe_raw.

nr_cpus=1, 24 reserved sizes 4096 bytes apart:

  nr_subbufs      head_buffer  map      head_buffer  map
                  unpatched             patched
  997 .. 1004     1            ok       1            ok
  1005 .. 1012    2            oops     1            ok
  1013 .. 1019    1            ok       1            ok

nr_cpus=4, nr_subbufs 1017, one boot:

  cpu 0           1            ok       1            ok
  cpu 1, 2, 3     2            oops     1            ok

cpu 0's meta sits after the buffer-wide header and the scratch area and is not
sub-buffer aligned; every other cpu's is, so the affected nr_subbufs differ
between them.

Unpatched oops:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
  RIP: 0010:__rb_map_vma+0x418/0xa20

With no reserved range at all, both kernels map the global buffer.  On both
arms, tools/testing/selftests/ring-buffer passes 6/6 with no skips and
CONFIG_RING_BUFFER_STARTUP_TEST reports "Ring buffer PASSED!".  ftracetest
gives identical per-test verdicts on the two arms -- 153 pass, 6 fail, 6
unresolved, 10 unsupported, 2 xfail.  The six failures are the same on both
arms and their cause was not established; the unresolved and unsupported ones
need pahole, a hypervisor trace remote, or userspace this initramfs does not
have.

The discarded-trace path is not measured: a fresh QEMU boot gets fresh guest
memory, so this harness cannot carry a persistent buffer across a reboot.

 kernel/trace/ring_buffer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..fa2e2ce683aa 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3627,10 +3627,8 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 /* Return the index into the sub-buffers for a given sub-buffer */
 static int rb_meta_subbuf_idx(struct ring_buffer_cpu_meta *meta, void *subbuf)
 {
-	void *subbuf_array;
+	void *subbuf_array = rb_subbufs_from_meta(meta);
 
-	subbuf_array = (void *)meta + sizeof(int) * meta->nr_subbufs;
-	subbuf_array = (void *)ALIGN((unsigned long)subbuf_array, meta->subbuf_size);
 	return (subbuf - subbuf_array) / meta->subbuf_size;
 }
 

base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.53.0

