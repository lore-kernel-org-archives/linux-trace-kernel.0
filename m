Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B59D3B0AF0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415930; cv=none; b=OBCfI619Mw20Cyt6NUW0PBIIQ+3tu3hD8ssUh7GXOGrvP8IqcehRSUbL04yaGOgz5yYhoXizpspBedBLFVt/0wiDlLmGW1/VCFE4y/BMIFl8QbbDkOPZlnBDX7YwAvFaZkdfILPrWJ+hnAJ0v2iH9DLGo2UbexWhzGjMZpf1iNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415930; c=relaxed/simple;
	bh=knzYAMdZ7Z1L3PWLzhIJWfUXHyu4LtwHAd3NfAWW4z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aSlqOTzQp7ZHciMtanJAYhzG3y1LmChglzkeDNzxzYlwb1W6tlrTJ6Q1frBYUC50hC+f3RlWvWvP7FhiyuIW4Tf4LU+nYmzomqiibJDeniCwcrTHC+EeAWSDp4ZMcx6nVvlXnIONojMm7Xuic0Exrt2cHrck668VyTN0xakqwGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT6hEsuQ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT6hEsuQ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb63dbd229so586767a34.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 05:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785415921; x=1786020721; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aTAGzT0qLIVYgYUYqDiXmvuy+nO45xCdWBehqOh4cHk=;
        b=cT6hEsuQPrQfQCc+wp3HgUteYEtnvFjZ7IfXuoKA0GbOLmIEd/NR4bRKWyI7s8/5aR
         U2ZLq6SAVzHRGRCxC2RfJ4ECrJV3+zD2kezjT+LElLXITo2b2UCwG/hGiOCO1MBjQfGI
         W1RAilNtmiyceGUUXWIxPsnF7BkHAAK85/Q4Dy7IKrSsMOSq5L6zTe33oml5g+yOKuGq
         75iGfZHz6CuDDNt3yefK9Xbmk43pe/QfqtMDZuJ1PGX+BTtJu1bMyPO5aNKFKF19Vy7D
         GCFUX8q7YYZRMi0sdgHBPAFVlasxJUiGcaodGeRQHkqUn/CC9foO0DmAlFAHguwT8I38
         ZpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785415921; x=1786020721;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aTAGzT0qLIVYgYUYqDiXmvuy+nO45xCdWBehqOh4cHk=;
        b=ohWK3Wmop0xAG2k3G1XpoaUCgRXqAvn1awZwtUIIN4wfdCxa9yD9FRMQFbHz+RcKE3
         IwORumb6Mhi9EgLvwglCuh4TmyNGQPOSZJOIRD2d406d+iVPsVRdzy9wCbuIsEmujDlm
         Rl4U2/cqVgtQ0dOzzGawXZY06NiqFjJnNcLlwM3oKNUCydhh5cUxPoo/oQgbIMZXZYyY
         XX1XAxsNp3d7TxTWiogEVDlcFJLP0g+knu4Vn7/31jBsSDkF2WqVUtk8Sgh3j13H89N9
         44CKYpTOJF2tC4FmzUcRHfpsgUuRgg21I261dfua/HokxgTp7MR/eTj74Uwk/t314NlW
         L5Ng==
X-Forwarded-Encrypted: i=1; AHgh+RqKCBjPT1YN37mPvvq6PrWu9TKArYMG7nsOJHt/kmBv3RibvJk9Zey1z38/BnxMds055/Gqtdt28ytIbWjsHKbPnAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb1gy0zFnNboJdFzZItSfmknphi3f1CZZNlboWphEIiaQpjCrW
	zRXYpyrbLVLznh/r/HsC53nJUhULW+9e/gar2F67CatkAgQk2hT5WEWt
X-Gm-Gg: AR+sD10/bXYiYUPFndLnGHjFVf+oVZ05aTyZ/mOLZASeyJ+2m7/z+UtLjye8SWC1gEH
	19pYHp120IFOg2KrcHIPz0ZzKHK2D1qEl3VWLdI7sRrOG9yrAyEzwTdXeU257wyTTzbCMfWa/xL
	Pbj8ArDVq5/nJm4u+16OxZWQywvdMkvTnuV0jirIr4mc/BP23UPmuiT87mV6MqgUfILK5H5DHtb
	v66fMGl9X22L43CRZkEzsyxc6VVjcbpOlYHo3+rPSBfE2XhV1f6uKm2CCNHeiJ5qaN2NHgjLQwK
	vLxbOvYvOgDfaeuWBX/1cLsPOGOVBKJP2b8Y4YO3Gmzlgy5czif/VIFV4TBnV309vX0yE/nkzXx
	aJ+IkoDk0zaFLkuy36yqFsIw8ZkLqVrBSc0dufjdOOT1fi1LCpJT2A/Xw93SmNzYthOoF5k/74l
	bYLg2Iip6LgFMo0NceqTh0SYYTHj8WPff1wZ08CP/Df07DRcd5bHE8WcJ/lv0X7JUszNT0fLY0V
	w==
X-Received: by 2002:a05:6830:10c5:b0:7e9:d34a:f436 with SMTP id 46e09a7af769-7f039eb533cmr134034a34.17.1785415920735;
        Thu, 30 Jul 2026 05:52:00 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d595384sm4696341a34.4.2026.07.30.05.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:52:00 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 30 Jul 2026 05:51:37 -0700
Subject: [PATCH bpf-next] tracing: Make per-template BTF id lists
 file-local
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-b4-fix_btf_tracefs-v1-1-5f10b728f51e@meta.com>
X-B4-Tracking: v=1; b=H4sIANhIa2oC/x3MQQqDMBAF0KsMf20gtdpCrlKKZMxMO5tUkiAB8
 e4F3wHegSrFpCLQgSK7VftlBLoNhPUb80ecJQTC6MeHf96948mp9YWbLq3EVbQ6TVFTnDXxzBg
 IWxG1fqUv8KYuS294n+cfMdq99W4AAAA=
X-Change-ID: 20260730-b4-fix_btf_tracefs-fdafda5fdb5b
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, rostedt@goodmis.org, 
 linux-trace-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, broonie@kernel.org, 
 Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785415918; l=4282;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=2rsrocGSAaAo8ifRN5ORoIxmWyXs1zf7huFeu2NqhU4=;
 b=MPYunR9XMbmuXVv2nRAa9piCzMCG3TG5A9iSS+drD3mZDyxXQPMxL0gagyzrxuz03b+sKn+L8
 xNNtnXlps6KAVaF9jc/qjzjbqX2eKsBM4/f5heGuTmfAMoww4CbV/FG
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

DECLARE_EVENT_CLASS emitted __bpf_trace_btf_ids_<call> through
BTF_ID_LIST_GLOBAL, i.e. a global symbol named after the event class.
The class name is not unique across the kernel, so the symbol
multiply-defines whenever two translation units instantiate the same
class.

Switch to the file-local BTF_ID_LIST: the list is reached
only through the event_class_<call>.btf_ids pointer, initialised in the
same unit, so tracefs readers never reference the symbol by name and
resolve_btfids still fills the now-local .BTF_ids entries.

The handcrafted syscall classes are the one cross-unit consumer: give
them their own local BTF_ID_LIST rather than importing the generated
sys_{enter,exit} lists, which are now file-local.

Fixes: eadc0725ab8d3 ("tracing: Expose tracepoint BTF ids via tracefs")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/ff58b01c-3f5e-4d55-be82-609d2faaf12e@sirena.org.uk/
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/trace/trace_events.h  |  6 ++++--
 kernel/trace/trace_syscalls.c | 22 ++++++++++++++--------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 09ad57ac4b73..45ffbe04b580 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -404,10 +404,12 @@ static inline notrace int trace_event_get_offsets_##call(		\
  *   [0] FUNC   __bpf_trace_<call>     (the BPF dispatcher)
  *   [1] STRUCT trace_event_raw_<call> (the ring-buffer record)
  * Exposed via the events/<sys>/<name>/btf_ids tracefs file.
+ *
+ * File-local: the class name is not unique, so a global symbol would
+ * clash across translation units.
  */
 #define _TRACE_BTF_IDS_DECLARE(call)					\
-	extern u32 __bpf_trace_btf_ids_##call[];			\
-	BTF_ID_LIST_GLOBAL(__bpf_trace_btf_ids_##call, 2)		\
+	BTF_ID_LIST(__bpf_trace_btf_ids_##call)				\
 	BTF_ID(func,   __bpf_trace_##call)				\
 	BTF_ID(struct, trace_event_raw_##call)
 
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 48ef1a93e576..9b5931f2f280 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -9,6 +9,7 @@
 #include <linux/ftrace.h>
 #include <linux/perf_event.h>
 #include <linux/xarray.h>
+#include <linux/btf_ids.h>
 #include <asm/syscall.h>
 
 #include "trace_output.h"
@@ -1305,13 +1306,18 @@ struct trace_event_functions exit_syscall_print_funcs = {
 
 #ifdef CONFIG_BPF_EVENTS
 /*
- * BTF id lists generated by DECLARE_EVENT_CLASS for the sys_enter and
- * sys_exit tracepoints. The auto-generated event_class_sys_{enter,exit}
- * is unused (per-syscall events share the handcrafted classes below),
- * but the id lists themselves are global and reusable.
+ * BTF id lists for the shared sys_enter/sys_exit dispatcher tracepoints,
+ * resolved by resolve_btfids. Defined locally rather than importing the
+ * DECLARE_EVENT_CLASS-generated lists, which are now file-local to the
+ * translation unit that instantiates the tracepoint.
  */
-extern u32 __bpf_trace_btf_ids_sys_enter[];
-extern u32 __bpf_trace_btf_ids_sys_exit[];
+BTF_ID_LIST(syscall_enter_btf_ids)
+BTF_ID(func,   __bpf_trace_sys_enter)
+BTF_ID(struct, trace_event_raw_sys_enter)
+
+BTF_ID_LIST(syscall_exit_btf_ids)
+BTF_ID(func,   __bpf_trace_sys_exit)
+BTF_ID(struct, trace_event_raw_sys_exit)
 #endif
 
 struct trace_event_class __refdata event_class_syscall_enter = {
@@ -1321,7 +1327,7 @@ struct trace_event_class __refdata event_class_syscall_enter = {
 	.get_fields	= syscall_get_enter_fields,
 	.raw_init	= init_syscall_trace,
 #ifdef CONFIG_BPF_EVENTS
-	.btf_ids	= __bpf_trace_btf_ids_sys_enter,
+	.btf_ids	= syscall_enter_btf_ids,
 #endif
 };
 
@@ -1336,7 +1342,7 @@ struct trace_event_class __refdata event_class_syscall_exit = {
 	.fields		= LIST_HEAD_INIT(event_class_syscall_exit.fields),
 	.raw_init	= init_syscall_trace,
 #ifdef CONFIG_BPF_EVENTS
-	.btf_ids	= __bpf_trace_btf_ids_sys_exit,
+	.btf_ids	= syscall_exit_btf_ids,
 #endif
 };
 

---
base-commit: eadc0725ab8d38c05148fce49f8d5c6a0e01f062
change-id: 20260730-b4-fix_btf_tracefs-fdafda5fdb5b

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

