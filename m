Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690A3101A6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961146; cv=none; b=kxMkWwMunvLzSoQuXQYM82nIabOEDSZya6rP/gwUG3dld4DwKecBrbyV5/SVu6sfBOBkj/4PSowyMmggBex5c2f9k72oE3rQ+kuRoBS8Dn36alKuTIi7qKeGjra4MxZdf+fLbEO4xJt/xXFrTEpqP+YCRPuruanCA8ICqymDTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961146; c=relaxed/simple;
	bh=XfQRc6MftvNdGzKZ46G4ftxOMPyAT33X22hT/a9QKts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gg84g8JqtRH8yvT8MtPNmwL0Fw+drJs59mvfBL8VVsJVVOz2LxrURdW4Pk2/WUiqANy/RKocLMy+NkhOP/s/DlCR1bSWeMvh9ohONoBOJF9TixnaRJazz3HqM3YcEmdOKgo7Sphq0y6GGv52xguO8wkwKAGxHfsz8U7bqLz+5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qub4m40u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qub4m40u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762961143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ulz0GZZr0kk+na/CJ75PpeKMohhecyZENnvNVFU3aY=;
	b=Qub4m40uCiklWnIOjgF/id0QnEBozucYb62vcr2nyP5FlQcCx79bTtZCXAQWNorDC9iJl6
	kmIgv8szCKtIavwNTT0robCsanSuP+mzUKPj3peu1G3p7qLYGAr7FZe4DQTSkazz58tMnD
	jJTJFpvLwByzghbc2HptkcoGxhobkIE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-O6eyzT-KMCaaOweXrMD7Ig-1; Wed, 12 Nov 2025 10:25:39 -0500
X-MC-Unique: O6eyzT-KMCaaOweXrMD7Ig-1
X-Mimecast-MFC-AGG-ID: O6eyzT-KMCaaOweXrMD7Ig_1762961139
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9486ebd1e4dso86419239f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961139; x=1763565939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ulz0GZZr0kk+na/CJ75PpeKMohhecyZENnvNVFU3aY=;
        b=gjghJgI/EJkJticnFLg4XvZFde2zLC2dQ8mA2mAfC+5jM5dkl+QuEV/tkT2oGj4vq0
         ac3Vo21ORYOPWK57wKFcDYZSefNt0uJ8MefYc2m0Ucm0u/St5B/gaAKE5geSckKE1M6F
         JMLgrUIC9tJY7MME/KXFBG0xWHF2ogCq26S0GPWKZr1gMeWQ+XXa8CSc18keG+fa8pis
         0htEHn2Z1MxxQKCzEkLLKL7ZS4UL+qUaLggD55TX0SV3nZ8H0XYyxTIpOPmGkCkXQy94
         kQ4mA/A3id3Jcm1HQSybO+PTrPIXhhCCRyCKb9G9U93iD2uSVx8tJ9N3DWTjHeh58Sty
         rZsA==
X-Gm-Message-State: AOJu0YxMt7Mvq9+yiqr0ogM9uSGAsY3GbASqVk+bRQHyVHj7c5oHXnvE
	X7dprJxiOxJ8t6UYZgiaIgsBN2Fdkn1UxCnKa1KprZAO6T7lL+eAM8cIkx2dVz/7wWbrlH1IEB/
	67PD+K/QNe1BwZHedWhTT/t9Dcn4CS9WluUvidGOSM7DTBdH5YRMbizEYJA5+qpkir/Y91rBQ7g
	==
X-Gm-Gg: ASbGncu+0GaVgT0CtE2cHuWqXji7OWeC8Q3f4MS3JnPPMVe0wfwcCMUdbguqiKPz8Tc
	OdssIjMCWSw/YY4kwzqgYkJfdM/UYOGX7mQWPwXeIX8JrlhjM8+Yg5AaLe7O8mfqZyQQVnC3+oZ
	lmNRyHTH/zUrTuS/wNhEg4ueB1gjfwArkDoylShJgKhOCEeTOFpVREa1omm8kRdf5EnjWHPW1OL
	6HYRoyAMBDMnbWoA1l2lEdWClKg7K7WRkwnMdYAwhC+ER2QJ7w6j77VLLZEQQwVOsPxg921YCMf
	viE3dPegQ/t8vXvgBwx2jKhs+eeZ/y1Cm5/cIoVhtNMbK/H+tNWZiTeJsyFnzJStdPVt5Ct3/b3
	x+CjjmS1rfhFcBoYFzR26RbLAngIhB0Q=
X-Received: by 2002:a05:6e02:12cb:b0:433:31a0:4e6d with SMTP id e9e14a558f8ab-43473d52e3bmr43886975ab.10.1762961138918;
        Wed, 12 Nov 2025 07:25:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGskPgpVQ+mL34ysPZe+SbtPKLs+wFcpDtUiBY2kRedVIlb8ygCv+i73uBKlXeXoEdZJpbHbg==
X-Received: by 2002:a05:6e02:12cb:b0:433:31a0:4e6d with SMTP id e9e14a558f8ab-43473d52e3bmr43886595ab.10.1762961138586;
        Wed, 12 Nov 2025 07:25:38 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4347327f820sm11680325ab.0.2025.11.12.07.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:25:38 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 2/5] tracing/osnoise: Dump stack on timerlat uret threshold event
Date: Wed, 12 Nov 2025 09:25:26 -0600
Message-ID: <20251112152529.956778-3-crwood@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112152529.956778-1-crwood@redhat.com>
References: <20251112152529.956778-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XnGukmwW4-f4PsHUUfERE7cuxgqIP6fpPIjnmh3ev4I_1762961139
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Dump the saved IRQ stack trace regardless of whether the event was
THREAD_CONTEXT or THREAD_URET.

In the uret case, the latency presumably had not yet crossed the
threshold at IRQ time (or else it would have dumped the stack at thread
wakeup time, unless we're racing with a change to the threshold), but it
may have at least contributed -- and this is possible with THREAD_CONTEXT
as well.

In any case, it helps with writing reliable rtla tests if we always get
a stack trace on a threshold event.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 kernel/trace/trace_osnoise.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a9962d4497e8..bb4d195ec74f 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2508,9 +2508,12 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 		notify_new_max_latency(diff);
 
 		tlat->tracing_thread = false;
-		if (osnoise_data.stop_tracing_total)
-			if (time_to_us(diff) >= osnoise_data.stop_tracing_total)
+		if (osnoise_data.stop_tracing_total) {
+			if (time_to_us(diff) >= osnoise_data.stop_tracing_total) {
+				timerlat_dump_stack(time_to_us(diff));
 				osnoise_stop_tracing();
+			}
+		}
 	} else {
 		tlat->tracing_thread = false;
 		tlat->kthread = current;
-- 
2.48.1

