Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806990;
	b=ZA8yvaX+2mwXynqv516nIJCnPkmVb2YQJC7dDBmzGTQ+usYSJnuZioMd9QgAhxUqAKtx
	 NkePZUFfn0MJr8fm/wVNvH/OXbnYDFuu/uUDrL7c3P6H22riIsx8NoZxHT0z6Bvbslo2C
	 nprTToRlNgUFUlAoblemEhj/2RTC4nnyxH3wyj0fLCIbw7pdTgDFEyKMqfOJb2q9tbzhK
	 ozd6ia/1K9aNyZ5LfBZCrBPjY/vvtRF/+RKASmDuRSLVqVmX1Z6Fmaf/sdLRi7n5KdRT4
	 utvwByFtLFVekOoEqE03hdS6cNszflCPc6aHtJ1s4vgNRTplhYx7g/OxTvcsLzDxczg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806990;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=ejTQYkiWTOyS/LcJCslXWyCKYpLRCfEQ5+6LndF2lC8=;
	b=Ub2dJedbZd1dbwy9e5O6XLzuuIaOQSZ7cc715s6OAwD2c4+8a2DLcvMTw2P+ML7e9Xs6
	 jFV0w4ryzXC8ckDm4Ewe/a+wuZdLzGgml/c//ur8/TFav9lKqZx4U3DU4ZkSQr1VFhT35
	 UdOsl9quqABBoY8BOo6cggVhyRBD9/lBQ/7fXpSsG7U8IkMqRglwfc6VYEJxha6NG/mmr
	 QPL5MLBEG6TBxY14vsocTnJgogO/4zbVIUIIH4hb+vC5VXX+rP4OstkAXzkQmnVtU14d6
	 ShES5LwssoCcNQtBPUozG8IaDYXCuWu9ot1laM+NjCYPAVb+mPmrSnZhjca3S6Qywnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xd7j+2Jr;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D89606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 01:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2D89606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xd7j+2Jr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792806989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejTQYkiWTOyS/LcJCslXWyCKYpLRCfEQ5+6LndF2lC8=;
	b=Xd7j+2Jr9W5+fGbCrXVHyfekTNRXPKu2K1Thm4bgktxJ6vbu9ZaOGdwMvz55xY+sljnQYL
	cNOeb0n2oV4IWeavZwjovlkxhopNiC+OT9gNcpeqdG7CuUBYgA2fHowXy83xL9/eIRmuG6
	AnKm6EBjEkb/p5XHw3+DF3QS4c5g+ak=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-NW2vz9OaP0SAuQ3cZhB8vA-1; Fri, 23 Oct 2026 21:56:27 -0400
X-MC-Unique: NW2vz9OaP0SAuQ3cZhB8vA-1
X-Mimecast-MFC-AGG-ID: NW2vz9OaP0SAuQ3cZhB8vA_1792806987
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-917a7c17166so32421656d6.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 18:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792806987; x=1793411787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ejTQYkiWTOyS/LcJCslXWyCKYpLRCfEQ5+6LndF2lC8=;
        b=gkctgCifRaPLJPDi+LfN56Q28z348tMA4HU/h7bZQ0exIA/IJ26YnihPDuCLhj6GE2
         2huc7UZc8JmxS1WOl6Mj56LcL8AQW0kX2SHcs2YMkXSc56JglQ5a5brqeT9/s+x+pTJ3
         tEsXUwtt06yJ/lxcSEZZQrbJQRq8gjBAMIz4l4XHkOkEwWK8VSsFgsj7ZOoboX0Nn7FF
         NK1FlbKCHNA3OdqBIbTdZvDYQhkRpjzF1Zr1glzN553eW8VpLID9UdmlTkQlDZ8KChgG
         IyxnOCuvYbnYwMYe4jnB1rRWV0Y1oTjd8dPdZcJZTQv9Ni4Vo98OpUVEtGKrveYBed49
         0cvA==
X-Forwarded-Encrypted: i=1; AKwUvBwHdmFs3ouDRMokV4FffJ3gm+ygrWlmF/E8o2MhpygBqCmVAG2AP0L8qXBe/1P4jG65UvyO1XM0SbMlm7rN+6erWNs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDIC+vhpzTnbr86d5xOGgYoKI/YdYtBR4Itb1GYf980kXuVBsi
	gHCNNsslRVbQIMjcEqRUq7EGk4rqSy+Rury8vCuZ8fGasRuim2JFzHYkxdJxyIFsmLVjceIEFVb
	Bm38Vu98pBW/2CQIUCXMxvHh+uHiMRIWzHpNGW8bmBcp0N0yTOwEJhGo2Ezj3lGK5IV56dP9voQ
	==
X-Gm-Gg: AYBFou3owxBpgJ/c0Ud7v8TT0nxtZA6AiXfA1Aa1rWvGqayoPrhkFU0DqzIC/MwakXD
	ZrsLl2jaX2PILftZugOzqejlPI/M2BbPMIK1IH4zcqvuFq1h12SLojPdqN0W8BBMojssEMfbU8d
	ee8OjE9srvkinJZqZ4qmLTS9/tB6w7RpyBQ2IsSlj0Ivvc4pABX5dWQvR+doS+k24GYPL//9s5z
	tO0VqzTV/oiZAwaM9Yi5FhVSIoTFhYaB6Wn4st9tgJ+sWvPwBmWniCeObuadaXKIfROmouX7bdC
	s02At2teu7aon33pCIdPwUo3yXFkjc9Jo11ga4l78UuMQTnNckYtOeNxza5Bx3KFUn0xHkFB//h
	YNbyEsNyvMb3HBxl4GGVt4EYZMGHANFmt40y0CJQvYIsXepwMryqzo1c=
X-Received: by 2002:a05:6214:5243:b0:919:557c:f0a1 with SMTP id 6a1803df08f44-91c48e2f161mr12577606d6.24.1792806987172;
        Fri, 23 Oct 2026 18:56:27 -0700 (PDT)
X-Received: by 2002:a05:6214:5243:b0:919:557c:f0a1 with SMTP id 6a1803df08f44-91c48e2f161mr12577436d6.24.1792806986794;
        Fri, 23 Oct 2026 18:56:26 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c4c6besm9448136d6.23.2026.10.23.18.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 18:56:26 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v5 7/8] tracing/osnoise: Print taint message for timerlat
Date: Fri, 23 Oct 2026 20:56:13 -0500
Message-ID: <20261024015614.3095251-8-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: S_3_MsFaPqOsG_i1njPdjdBd2db3T8qXh89nYUZZQDE_1792806987
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Provide taint information the same as is done in print_osnoise_headers().

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: new patch
---
 kernel/trace/trace_osnoise.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 9c7470ef4b03..2bc23a4c1b06 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -576,6 +576,9 @@ static void record_osnoise_sample(struct osnoise_sample *sample)
 #ifdef CONFIG_PREEMPT_RT
 static void print_timerlat_headers(struct seq_file *s)
 {
+	if (osnoise_data.tainted)
+		seq_puts(s, "# timerlat is tainted!\n");
+
 	seq_puts(s, "#                                _-------=> irqs-off\n");
 	seq_puts(s, "#                               / _------=> need-resched\n");
 	seq_puts(s, "#                              | / _-----=> need-resched-lazy\n");
@@ -593,6 +596,9 @@ static void print_timerlat_headers(struct seq_file *s)
 #else /* CONFIG_PREEMPT_RT */
 static void print_timerlat_headers(struct seq_file *s)
 {
+	if (osnoise_data.tainted)
+		seq_puts(s, "# timerlat is tainted!\n");
+
 	seq_puts(s, "#                                _-----=> irqs-off\n");
 	seq_puts(s, "#                               / _----=> need-resched\n");
 	seq_puts(s, "#                              | / _---=> hardirq/softirq\n");
-- 
2.54.0

