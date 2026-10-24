Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806992;
	b=m9l+OrLhPhA0tvzmgfRefJHoHZk8pOU3VSlyoedhdZDknCCmNb8cbCv4fIhbsayv1C/b
	 MBFqcrbVlA+AIoC0OlBWu0+Z8BPgW+cOsl19DvNeqF1fEfrsTThLHn0yyiG2y9gha9SbM
	 yBpa5VXVeZjRlt2XE4h3VQjceqvCIo5prWa95p5FSXWQBwLJv1HkhakcdXyRdLZQv0qdY
	 udxr45j3TsvXBARFQ34eaRV08u3Y091EL95HWWv+kwc21iAvVWG3KQP4JrG3qYJB+y4iA
	 z0t7i+W1lIms1DuvJc/o6v6x2I2spN4U8ohG93Z1Yx0MdTrFEpabPIPH7Qj8PfxUqbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806992;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=p8kp6pYy1qbXUVPQJbb24WK5kI+quUDiveymyi5jr20=;
	b=qiQNIz80jGknbd1EhxLIkiyMI3ksYHNmWZCWxrgKZhFsBIskw4zE02WnvMNFbTK80ZbX
	 AAHI1mJe6WtAJY3cpmJIQU2wisTtBsAsZ4zjTiDQO2leT/z6EfmH1U3xLM2EAG9UiOlZq
	 2j2tni/zPFz2/Wg2OytZMbTktAvrV+ElX41s/Ggwaqe3r0vSyyqhMoPMY0KCtMaCp/Syd
	 4xauTnkkJyNm73RTQVGa711mvJLmdF0ADFCnp+N6jniCPi/q6cbbC3jetZHvcD+YrM6Mv
	 TuzAyx7UN5lZfSbarJtdmK7860duNV2FR6Co1QCDgtjJ1u8Pr2WAiCI+B2/3W7uNI/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XxL2074z;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD22606A31B
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 01:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD22606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XxL2074z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792806990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8kp6pYy1qbXUVPQJbb24WK5kI+quUDiveymyi5jr20=;
	b=XxL2074zo7WwMWFcBeoKOIrTY6IulLb4ipU7n5RMk0pUoyu9bHAj+fqmrV1KMjCG1Tr+YW
	Ll8ZbEqtuyUGfE5n0vknsuf/H7LVpIA2ODta/aOXB3wnnXL3lU+hf6wk98Ch6ToiB+ETBw
	yenS9fAQpaHGHTQj8rjC/cng9TMjfFg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-J7QPU2zDP9qOm9cb3JXrWg-1; Fri, 23 Oct 2026 21:56:29 -0400
X-MC-Unique: J7QPU2zDP9qOm9cb3JXrWg-1
X-Mimecast-MFC-AGG-ID: J7QPU2zDP9qOm9cb3JXrWg_1792806988
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91b994cb09fso35162736d6.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 18:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792806988; x=1793411788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p8kp6pYy1qbXUVPQJbb24WK5kI+quUDiveymyi5jr20=;
        b=RZE3K5AgAyD6XLc7W5UimBDsfSF7scHQQiA/YqatPEaAd3qFSS+DpXEyesSYqtooE7
         uBzYiV/XlprAB3QgEyjrHpv4yEgSY2Zj5sOfAD0iRiyzbOdpycK1rR9psWEQiQQArkjJ
         rM8at1YczSm6N/JPOk6udNv5CFBNRqMnd37zf3anyFWeRoLjYYjVozbbzFNNzYneu8E7
         y8E0AGZ5ln79Vjc6hqzKMUriPeB/x+CP5HlBg4sUvmg2bDXCzLkOU96+tfTLPcEJnmDR
         PB/xXUGgKwSE8M5sy1aP6ENVxlllLJC4j05KtOriQtctYfYJLLMUEY5mmaJX7kdoouPw
         fQ4w==
X-Forwarded-Encrypted: i=1; AKwUvBx0UHJribkE4HiAchz9Swvob/VILht8oNskxEnJhNEBc701eUXO4PYaB633D8JuuEzLcf+ebUfp0AE9s/2DHpdkHP0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeRhebdcj7mgpH4SyGRxFJA1IrWDelXAtcgkwA9jtRCNm1BImx
	hw4tsHzu8WgVxfvd1A5VYRECv8OYpBOIYtWYDnAYmgFbOxrNiN2DeO8UDTfvs+nC3qP4UjlJW0Z
	ZqNxJE7qfJ9DhU2hy+f02HLuwhPF7/3/fdb1Iv2CoHiDJrq7nO8qhYLfKjsc2IrtnwG8miy/mQw
	==
X-Gm-Gg: AYBFou1uZfR6IWvTKDWepOazxpF1QiecCqHVisqL3ogCp2FLrJTl/uPmkcb6lAbYs0y
	uf0fLrxjw0lkWNJQskQJ0PuvSc6/pG69c2jbp0b8QzP8AUujnosYw/xdYBxs23de5/BjN+on63J
	cf+RAtYCHnLAWl4ej+NmZi9f7g1v+JVUZbFXIRRiNMv5NsSmpGvB5DtsPVTCaxn1vF2pIvF82rO
	Eiq3JgqJ9EOXfzWi9HMKGwq9mf5feXh6AYQTdzBZ07uCwdfZtKpEuK+VfB6pLDXdW/7HZKz9y/1
	IE9hVMptfPKUQlJzIe90kZcO4A5pNlzqeHxG3WrZWZpY7dLDD4i4nT+qPTEPEdhm666PVvngF0K
	BC0/hiIEDoOxtM5fxCEMpljH1HZ7contQsc3xURwnlfWVSsZwgt29+a0=
X-Received: by 2002:a05:6214:4805:b0:91b:d5d7:8c84 with SMTP id 6a1803df08f44-91c48d199ecmr12822996d6.7.1792806988499;
        Fri, 23 Oct 2026 18:56:28 -0700 (PDT)
X-Received: by 2002:a05:6214:4805:b0:91b:d5d7:8c84 with SMTP id 6a1803df08f44-91c48d199ecmr12822876d6.7.1792806988073;
        Fri, 23 Oct 2026 18:56:28 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c4c6besm9448136d6.23.2026.10.23.18.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 18:56:27 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v5 8/8] tracing/osnoise: Refuse timerlat fd open if tracer inactive
Date: Fri, 23 Oct 2026 20:56:14 -0500
Message-ID: <20261024015614.3095251-9-crwood@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024015614.3095251-1-crwood@redhat.com>
References: <20261024015614.3095251-1-crwood@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GRIsUfHATIvIhOBw8F4RGzg8-3Fmtol2Fir8nhO8c-8_1792806988
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Besides being generally bad, allowing an fd open when there are no active
instances means that osnoise_options_write() and osnoise_cpus_write() will
leave it active during reconfiguration, causing at least WARN splats.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: new patch
---
 kernel/trace/trace_osnoise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 2bc23a4c1b06..5835b9d77bb8 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2507,7 +2507,8 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	 * This file is accessible only if timerlat is enabled, and
 	 * NO_OSNOISE_WORKLOAD is set.
 	 */
-	if (!timerlat_enabled() || test_bit(OSN_WORKLOAD, &osnoise_options))
+	if (!osnoise_has_registered_instances() || !timerlat_enabled() ||
+	    test_bit(OSN_WORKLOAD, &osnoise_options))
 		return -EINVAL;
 
 	guard(migrate)();
-- 
2.54.0

