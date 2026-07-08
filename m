Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A02E3F825E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497479; cv=none; b=WOo9myBPV19AhWOMd+hmEzySlCkz/YX+dNHivlOItaWKMuw1Cv5SRx1fBozzDX9nKuKkYYjimYAZNaQLV51CjLSB6dB/mOJm/+ljhL4WyVFqirzc2CzagTuFHteDw4LXOn5r80l4ge/xiu9LA110NPlyYRaA2nB/j7jqPK0bJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497479; c=relaxed/simple;
	bh=hZtsxisaPTY5ToDb2Nu0+RQ+BpvWxp67/nOUGgZNJ/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ct78hHu+5KFMgldVNhldK5a7T8JIFWFvqRbSW1GYyTVOxNqwMirazibVrpNPdEqGdzrNzrzRGvayPxurLItGuy8yI7TGcWnnLhPuwesOxOt4B6VNYMxPmtJPL81p8Lii7gFV1NUrUwrFRtQ47o10b0KKreqeoTnSwdJsnp9cEAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lma3smHT; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lma3smHT"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c12823d7822so35651666b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jul 2026 00:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783497468; x=1784102268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9u8vK7y24l4tdEbBKumAzRQyzhCWiiUx4/oaY05z2cM=;
        b=lma3smHTyd8ra5q5Q+/i49sPp+cNmQAbhL80w2O9tE4PlKtgb22EqWjwpYelCuV1hf
         0Ss/17SmHarkzN71PaiRAMXmI4HaW3IsNwbGnj7OpFPR23xwXtPf6ZpPfjbd1JFjNyV/
         nE77zw45qEFXBLFIkBAZST+mmyhOfwLyMyTyCofz2qo1wQqyUpXU4z3O3qppt0SMCkfA
         nbOdvHNJ5BPEJjy1y4WXvF7ZUJLysWsvd5JW9+gCqp1nXpieCDRkTp06fQnpamH9U+30
         uBQlYo9ZZDrrxsqdCVofaKVBSiIKU1K8qOMgOzQ1NWTTKUHuDvoMs7XxO/uA/w67BVjF
         9f/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783497468; x=1784102268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9u8vK7y24l4tdEbBKumAzRQyzhCWiiUx4/oaY05z2cM=;
        b=HVW2ud7+cloAvac1yIRTTuPDqLxykAXrbSxqIEuVKL7z4ZGscB1t2Ucg+K+KYOzpcK
         jvZojHEdlNe/Q1H95chSdRw+40Ri2TF+25HgMW5p+qERV0cqMT3MdyPb//IAGCjXSWmi
         6ZLeaVKNzoSphClWEa3J+Qf+o8HPi4NEpApOQsvzaojbMcpesd/zkOaZOZTRAcoYphUv
         DRntTjiPNeLhev/hz86ZFu90GbQ0z4CNpWCU2883qcsUjhrkn8Ng9UWOTQurrn/ui+Eq
         HTcOZON9yTNNnMA1L9RUf7jPY4r9cBm3JyJXfhnTfIlHkChRDl5FwMSLnLFIHqpwDe5u
         0hJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmbGoI7eMAzb1wIVt9wDdETFHLR2HDH9mRd1SrVvMoTLP3Inc3bIRgeJQ1V38g9B7wF2RgeDpjx0WZOvJGD4BZNJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07kZ9uYl48RmRLihRActx669MpX0eX0TQ2L5FdEfQgv9RubWZ
	H7wBESUbJinFgvQjh3nvkHwilViwdTpa26qFELAtfm4fLRgFwXkQBaebVRjh62SFm0D8r98rN2z
	QhSt6uM26DtEuyLD4vSggYw==
X-Received: from ejar8.prod.google.com ([2002:a17:906:3508:b0:c08:301b:2ab6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9454:b0:c15:b9b6:6b17 with SMTP id a640c23a62f3a-c15cdec7abfmr74573266b.4.1783497467071;
 Wed, 08 Jul 2026 00:57:47 -0700 (PDT)
Date: Wed,  8 Jul 2026 08:54:34 +0100
In-Reply-To: <20260708075435.47419-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708075435.47419-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708075435.47419-4-vdonnefort@google.com>
Subject: [PATCH v2 3/4] tracing/remotes: Add REMOTE_EVENT_CUSTOM_PRINTK() helper
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, rostedt@goodmis.org
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kernel-team@android.com, qperret@google.com, tabba@google.com, 
	linux-trace-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The current REMOTE_EVENT() takes as a __printk argument a string format
and a list of arguments, such as RE_STRUCT("foo=%d bar=%d", foo, bar).
Add a REMOTE_EVENT_CUSTOM_PRINTK() where the __printk argument can be a
function. This intends to support the creation of a "printk" event for
the arm64 nVHE/pKVM hypervisor with a dynamic prototype and by extension
a dynamic print format.

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/trace/define_remote_events.h b/include/trace/define_remote_events.h
index 676e803dc144..4f4d58e37b84 100644
--- a/include/trace/define_remote_events.h
+++ b/include/trace/define_remote_events.h
@@ -35,17 +35,26 @@ do {											\
 
 #define RE_PRINTK(__args...) __args
 
-#define REMOTE_EVENT(__name, __id, __struct, __printk)					\
-	REMOTE_EVENT_FORMAT(__name, __struct);						\
+#define REMOTE_EVENT_PRINT_FUNC(__name, __printk)					\
 	static void remote_event_print_##__name(void *evt, struct trace_seq *seq)	\
 	{										\
 		struct remote_event_format_##__name __maybe_unused *__entry = evt;	\
 		trace_seq_puts(seq, #__name);						\
-		remote_printk(__printk);						\
+		__printk;								\
 	}
+
+#define REMOTE_EVENT(__name, __id, __struct, __printk)					\
+	REMOTE_EVENT_FORMAT(__name, __struct);						\
+	REMOTE_EVENT_PRINT_FUNC(__name, remote_printk(__printk))
+
+#define REMOTE_EVENT_CUSTOM_PRINTK(__name, __id, __struct, __printk)			\
+	REMOTE_EVENT_FORMAT(__name, __struct);						\
+	REMOTE_EVENT_PRINT_FUNC(__name, __printk)
+
 #include REMOTE_EVENT_INCLUDE(REMOTE_EVENT_INCLUDE_FILE)
 
 #undef REMOTE_EVENT
+#undef REMOTE_EVENT_CUSTOM_PRINTK
 #undef RE_PRINTK
 #undef re_field
 #define re_field(__type, __field)							\
@@ -70,4 +79,8 @@ do {											\
 		.print_fmt	= remote_event_print_fmt_##__name,			\
 		.print		= remote_event_print_##__name,				\
 	}
+
+#define REMOTE_EVENT_CUSTOM_PRINTK(__name, __id, __struct, __printk)			\
+	REMOTE_EVENT(__name, __id, RE_STRUCT(__struct), "Unknown")
+
 #include REMOTE_EVENT_INCLUDE(REMOTE_EVENT_INCLUDE_FILE)
-- 
2.55.0.795.g602f6c329a-goog

