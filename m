Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43BA4756A3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015710; cv=none; b=MSTSe5aMEbNE6N33VmdIb4QMYujxc4NxJf4nyIkalBLfJXQ+oENk7iBSE8jD/pTYzbP4H9UdvOYB7MBoLz6EnBrbe7hxMRKYTGEH3libbrbWdrVAUZnCsSd8cIxsCZeESWyJhhi76Dh6nAX0QAE0I63vE85AA19TFa3JG9rfbyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015710; c=relaxed/simple;
	bh=brUREapd/gSV0e2DO1at/Cz+IbvpnAyrRRPy5DJ1h3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=XDxxgNAxnJqNpr/nZNCAWUXnJImO9smfh5jECPkcTzXruczL10ZxOMg/mfHxidX3p8Av7oLZRdaqqaScuesfviqwkM7h0YRRjv7PocUXKtQ6Bqx21nzyI+s7o+elP3ji24p0B/TGKJuwZiD9qbUZM38o9CHbDIzPS5oQe2UfuXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgkUeWib; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgkUeWib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792015708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUlatNCTGq2SARX33+T6v72U5tvdDEfTqgDTgcn4rFM=;
	b=PgkUeWibtPAxNF3jbKoEI7R8g6icZa749oTKiKqCPjmjk8SOT4i8MNg8pD9HJ8pLzDo6NS
	HeX2zvRNV876FtLfd3hDYf2IzRvreyANaYE3NEHF7fl8etTHk4Yf48WpLMSiuQA3N4+MyY
	2V5KVcP5429Oy10E3Ol3cUtPi0H6OhE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-h8uOQme4NC6CvJFl3HW1lA-1; Wed, 14 Oct 2026 22:08:27 +0000
X-MC-Unique: h8uOQme4NC6CvJFl3HW1lA-1
X-Mimecast-MFC-AGG-ID: h8uOQme4NC6CvJFl3HW1lA_1792015707
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5340b037c6cso11198481cf.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 15:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792015707; x=1792620507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UUlatNCTGq2SARX33+T6v72U5tvdDEfTqgDTgcn4rFM=;
        b=tgsFHn9gDS7Y5F3qUOgns5pFgqNTMDCG4zg11QATGTX5alx9cx4ZaLpia61oXBsneF
         wRDg6dzg9IQBXq4eRro2NNCdzk+rUbVZ3bhdM4LARzbXaeKrc5TgQb7356b6OzTOV/fw
         yfpcCAqXbOv7X6BPMNkktSZURd8QDqZ0Ayu17FKd/afwcLMhPLYe1GPXHChhNvo2s7+R
         q9UiJf95aklwsDUlciFATo5qGVhNq4lultxfzeETPy3WGFbezG/cEJZgJ1wLS3xVqJbX
         gLPXDwcuh80XuFXE9ev2uyAf/g8i4t6deNF+rwsc07ByFyE/Msm/rltjYr1KbkmQBJ6w
         M+UA==
X-Forwarded-Encrypted: i=1; AKwUvBxWKJc6fHv3F9Kv98h3n9ujKg1ofrQ6f/nkDbbqvj/7rHfKq0IUMM19BKl4gQpl4NN5epueVuxP3DFLmmXj1mvATbA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZ4RG7HOabK2PoHMH4fFoIahbtm8bqPnENP6Y6tSHa/tmes/Ge
	kKY2KXT1Tj+xchZslw8mZ/tuCv3Fy/neJcZukPkZber1a3UrxkRiGHN4R2iUBSGyZIDaIwRCy7g
	eOj+QO0dsSz7/DDCItmNP3d54pBgYiymz1tXE4g334CijAWT59ysIFEhemWTlwt9tTPZ3w52lQA
	==
X-Gm-Gg: AYBFou1PjC7bctYUrJIzBEyRn3xZxbmTUjDsjtSTiy+5qzSLA5ECB3KxAss95+x+iXs
	TE4EA7n8Oy+AHE9/i+zdAb3RSj1hHkuGBDio4ZjA/cnE34FmKRoFBMnNCiOm3Za31loET6/Oe5Q
	xvDjWsrS0TlvbKERYkMuFtGdSGM5rm1d/afH095GGAJ+3S5soSkNMEcH/sptskHw1FrI2kbKM4k
	/SOS8ufL0X0RWnKFV8R+g2zTM75mwzb14d3qqr92N33xerV84/nIjFcH1JVTAPqhI9QJKCj4hhT
	3F/2WcMRUPvf975RV27kaJXbOsU6tDgjDq/F14a/nhyF5Gwa5aHeQPKzQTyQde22z8t85i7OTaZ
	OslKyYzYPl0zsj0veSwn07YHbHliJMan4dGzSTw668vn/nzImRw9HMAQ=
X-Received: by 2002:a05:622a:844d:10b0:535:a5fa:ee09 with SMTP id d75a77b69052e-535a5faf207mr188985441cf.73.1792015706620;
        Wed, 14 Oct 2026 15:08:26 -0700 (PDT)
X-Received: by 2002:a05:622a:844d:10b0:535:a5fa:ee09 with SMTP id d75a77b69052e-535a5faf207mr188984811cf.73.1792015705792;
        Wed, 14 Oct 2026 15:08:25 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127b5567sm8224761cf.12.2026.10.14.15.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:08:25 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v4 9/9] tracing/osnoise: Refuse timerlat fd open if tracer inactive
Date: Wed, 14 Oct 2026 17:07:59 -0500
Message-ID: <20261014220759.908839-10-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014220759.908839-1-crwood@redhat.com>
References: <20261014220759.908839-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tNguiy0SQqFw1RRqF-mg1LBxzrQPx23C3RRaCh31n9o_1792015707
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
index 40b6f3df8a20..8008b54d2875 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2506,7 +2506,8 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
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

