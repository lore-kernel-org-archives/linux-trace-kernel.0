Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844175;
	b=NSCHoidND5B75uBgwGCaEmTL476lRPTxel2vNecXP8TrneDfGgBTvs4n5P4efE3LdxEy
	 UseNmcTI49pt3DnuouviUqw9KZVwQGAu+9g3RvSEpMfU37qGgW9P96lVanN4+jiLGqQyh
	 rCAvanWVmxHgg3FrlTSNsouPkBufLVYN6iE0Iol2KZ/WWec/zJcqDs5NOHpdrxi3z4Cgp
	 BTxw36c9FL+N3sq6zyb4WAaLdrEzTDE92P++2XbiM7Yz6tUsIlJw2L1LBlDH2fWAV9Hb9
	 K5faotfil4DQPwdg1FpBxCAJdWqFzj3FNrvCmhgdmSCdBdJxur2fDXgj1K/0cSoLUWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ddi8ZLCL2hOZfi+sAkv5V27pHP2I/vbEpCnwvcWNBys=;
	b=gXztYMdApGW6jkxO+sc0OTM+uQe2tbqaZRCbHfqRxYEcOErH4k3FxHSriExbL4+eqSxV
	 hqDU99CHL8tyC96dcvFlTN/7k0/MxCUTOutxaZRP7YYYqvbN1T9D/GtAmJobtgeNnNTIm
	 74QRtw4cvnbODP0Ecnxqs26IAdoSrZCzrQ0WLRoedykqU8f0Tz1MVGmBsvAPW4ZWLmSk3
	 mltSmMwRYHppg0UQf5akl4bq0yHvBCVcrrNwWl8qZtv5KPte80KKp8hGqFrvAmKOC8yZV
	 VrVfDJTlMQy/Qe3/S4mWmjyEY8gDou89lyyB20n6JmVsX0Ow4ZEIPrEHBi+VaF225zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0XltcJOT;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608F5606A31C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 15:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 608F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0XltcJOT
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so12008825e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 07:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794844174; x=1795448974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddi8ZLCL2hOZfi+sAkv5V27pHP2I/vbEpCnwvcWNBys=;
        b=0XltcJOTj8qBuNtrY72600QfOB1p0BYfaOyWxa6sfrFcPWWv9Wv5U+HZ0nLB2jSYBE
         H9uLZ6XXKriVNS/p+9xSgz2TPj2TPVCLCmLWYwOEis8NDtkBH3GJBbA2X3hsjdGEWAc3
         8pEfmuUNkgmFnafHxuO/oyDILnZ5DwGPgxwJDIq9GEPpwXs7YXivG2PTuMWPRSxJX7kg
         yxM07gtdVqya8PILauVaFS9Nx4+awJINSbgxRUCEy+JOrMNZM41JqsODGV/jeBXKoX/+
         OWTygCiYC+O0mCwkeLlJlnUQjNTRumVj8Ej9ggVLaHkLb7TUKRxsrGQSSt02GV/qV0tL
         Il6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794844174; x=1795448974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddi8ZLCL2hOZfi+sAkv5V27pHP2I/vbEpCnwvcWNBys=;
        b=HTCYLiP1aqi9cPvfuzknnWKK6zCAj0/tqIY5AebOMG88MfDiIfUclA5MqDH5WZg4zG
         mCuwSQVzrzxnx6LJmCyb+J5m3Q7g6mrY3X9vZwcYbu2LBR32MPJeJORwrqDGMSBUs8Fq
         XFHHu/4RTMcEkf+LQCx/9Sg4JE5MjxS/3JFjkAcEvnvxtRy1I+RlNg0qA1XiLOaN/AM7
         KpSEiPhLAsJcQX48GUCt65cXr18ZTRik9ashm90E4F+47ssRRDwYPijXfvm+GylcFznm
         5Cjfxd1ArsiCi+2nDr0D16wTWNtRFTYS8u5/Tlw73o89CCqquknGvxdWfUqCBUQki+bf
         p9Gg==
X-Forwarded-Encrypted: i=1; AL+hErG7js5LE6Gj0IwoAdNMiDgQSFfMHGpKJFt+UMlMOhfvVEjrJ+VgKUuoYoBoKp2lJturXnrKCpHu/LIlrB7+Zv7OBYM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mWu569NR9fefZPQQcHShnrd9JQaqb+FIgtOmrrvZrUBQPNtwX
	yXv9PsDS0eIL+hMuCalyjNAQqYKQWy3grkJWcIliSfDudIoPQhNi0gvf
X-Gm-Gg: AYBFou0wKuoDHTfObkpF1hMsgF+S0PPEQ1evPJbmMza+GHc2RP3HLVaapQ5qffKfcM5
	I9NrW1BxpXEduMt6QmZUa/1fmgXPD7JOBDVNG8HWPLTBYvsABXoKyBCZfjiE2WkxI59ulEqWJa0
	hsoUw7w9GP+mUJFyhM1vW9VSq9ugWhsG717wX9FxRbstkQzNa5GlQytc6UDvv/fKaoU09Iyr9Tp
	FEanRU22cszdeBxxZELt2y+Whd/THYPO/wlT4dj4ow52+q5tQX2r6Q1wAN8aThc/jynQmCuMryn
	yjoJAAKh0qWAjm61PS4ZNVMo9UnLQU5opurBzJupzfGmocEUxmU2mgjAMv+I+DwwG+FlkbRtsPb
	3QN9LrSWXfGXj5ZLcpPayKUA8cyKX/2KO1mE/HT0enzF5I4++hfPt/UGlu/bn7lEhq9nTzCqksW
	DuKuSn65MWqqhOF0ogigs1Q97TA4aocwfOukv2CezyfDAbSyP5EqIsjarFs8X0FaE1smVT5rSLX
	wa6Kpl+0CI/07kZbk58WvOhfLvis24se+0lxQHAxQYFoSNzY0uVVFyTXTjLFuJ1dknQdkOTBrIi
	jV2E//RRbziw8LxUxNhX/FbIMs1OMlOYt7gJ4hHRr1B+QSGRxCEtX5zpB8402WzsB2lokxcru+v
	f9BJF92aiDeCiZM2Tu1SgIUJxJktfyy+ik9tFcg==
X-Received: by 2002:a05:600c:1d10:b0:4b2:3c81:d1 with SMTP id 5b1f17b1804b1-4bb55a65ea5mr218622945e9.5.1794844173463;
        Mon, 16 Nov 2026 07:49:33 -0800 (PST)
Received: from DESKTOP-0KSTGNI.localdomain ([41.44.127.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a2f61c0989sm1107290f8f.48.2026.11.16.07.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:49:33 -0800 (PST)
From: Temitope obabi <obabitemitope765@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	dhowells@redhat.com,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Temitope obabi <obabitemitope765@gmail.com>
Subject: [PATCH] cachefiles: Remove unused cachefiles_prep_read tracepoint
Date: Mon, 16 Nov 2026 17:48:52 +0200
Message-ID: <20261116154852.7765-1-obabitemitope765@gmail.com>
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

Nothing calls trace_cachefiles_prep_read(), so the tracepoint is
unused. Remove it, along with the cachefiles_prepare_read_trace enum
and its name table, and the entry in the BPF raw tracepoint null-args
table, which exist only for this tracepoint.

Fixes: c990057233d1 ("cachefiles: Don't rely on backing fs storage map for most use cases")
Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
---
 include/trace/events/cachefiles.h | 64 -------------------------------
 kernel/bpf/btf.c                  |  1 -
 2 files changed, 65 deletions(-)

diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index a19233e8ae78..8380a4156c4e 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -72,17 +72,6 @@ enum cachefiles_trunc_trace {
 	cachefiles_trunc_zap,
 };
 
-enum cachefiles_prepare_read_trace {
-	cachefiles_trace_read_after_eof,
-	cachefiles_trace_read_found_hole,
-	cachefiles_trace_read_found_part,
-	cachefiles_trace_read_have_data,
-	cachefiles_trace_read_no_data,
-	cachefiles_trace_read_no_file,
-	cachefiles_trace_read_seek_error,
-	cachefiles_trace_read_seek_nxio,
-};
-
 enum cachefiles_error_trace {
 	cachefiles_trace_alignment_error,
 	cachefiles_trace_create_nospace,
@@ -163,16 +152,6 @@ enum cachefiles_error_trace {
 	EM(cachefiles_trunc_shrink,		"SHRINK")		\
 	E_(cachefiles_trunc_zap,		"ZAP   ")
 
-#define cachefiles_prepare_read_traces					\
-	EM(cachefiles_trace_read_after_eof,	"after-eof ")		\
-	EM(cachefiles_trace_read_found_hole,	"found-hole")		\
-	EM(cachefiles_trace_read_found_part,	"found-part")		\
-	EM(cachefiles_trace_read_have_data,	"have-data ")		\
-	EM(cachefiles_trace_read_no_data,	"no-data   ")		\
-	EM(cachefiles_trace_read_no_file,	"no-file   ")		\
-	EM(cachefiles_trace_read_seek_error,	"seek-error")		\
-	E_(cachefiles_trace_read_seek_nxio,	"seek-enxio")
-
 #define cachefiles_error_traces						\
 	EM(cachefiles_trace_alignment_error,	"align")		\
 	EM(cachefiles_trace_create_nospace,	"create-nospace")	\
@@ -210,7 +189,6 @@ cachefiles_obj_kill_traces;
 cachefiles_obj_ref_traces;
 cachefiles_coherency_traces;
 cachefiles_trunc_traces;
-cachefiles_prepare_read_traces;
 cachefiles_error_traces;
 
 /*
@@ -468,48 +446,6 @@ TRACE_EVENT(cachefiles_vol_coherency,
 		      __entry->ino)
 	    );
 
-TRACE_EVENT(cachefiles_prep_read,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     uoff_t start,
-		     size_t len,
-		     unsigned short flags,
-		     enum netfs_io_source source,
-		     enum cachefiles_prepare_read_trace why,
-		     ino_t cache_inode, ino_t netfs_inode),
-
-	    TP_ARGS(obj, start, len, flags, source, why, cache_inode, netfs_inode),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj)
-		    __field(unsigned short,		flags)
-		    __field(enum netfs_io_source,	source)
-		    __field(enum cachefiles_prepare_read_trace,	why)
-		    __field(size_t,			len)
-		    __field(uoff_t,			start)
-		    __field(unsigned int,		netfs_inode)
-		    __field(unsigned int,		cache_inode)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj ? obj->debug_id : 0;
-		    __entry->flags	= flags;
-		    __entry->source	= source;
-		    __entry->why	= why;
-		    __entry->len	= len;
-		    __entry->start	= start;
-		    __entry->netfs_inode = netfs_inode;
-		    __entry->cache_inode = cache_inode;
-			   ),
-
-	    TP_printk("o=%08x %s %s f=%02x s=%llx %zx ni=%x B=%x",
-		      __entry->obj,
-		      __print_symbolic(__entry->source, netfs_sreq_sources),
-		      __print_symbolic(__entry->why, cachefiles_prepare_read_traces),
-		      __entry->flags,
-		      __entry->start, __entry->len,
-		      __entry->netfs_inode, __entry->cache_inode)
-	    );
-
 TRACE_EVENT(cachefiles_read,
 	    TP_PROTO(struct cachefiles_object *obj,
 		     struct inode *backer,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 538129ed2418..c6403edf97a4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7264,7 +7264,6 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	{ "cachefiles_lookup", 0x1 | 0x200 },
 	{ "cachefiles_unlink", 0x1 },
 	{ "cachefiles_rename", 0x1 },
-	{ "cachefiles_prep_read", 0x1 },
 	{ "cachefiles_mark_active", 0x1 },
 	{ "cachefiles_mark_failed", 0x1 },
 	{ "cachefiles_mark_inactive", 0x1 },
-- 
2.53.0

