Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13838887D
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599055; cv=none; b=HCGsYoURsxJs6RSvyTRTx0eNSIdkWWNTGik4YC52GxY7WB757Ij+4UVDvYDkUJxh4aQVX3E7kFI2yViKoPh7flJf5AL40WTQuzCPN4nzQXx6GhImCiTAUpgKHcU3iBQl3mQbplefQx6sSd0I2Ytd0TpYOC4sz/8JrCkdoWK0Yx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599055; c=relaxed/simple;
	bh=tit/D+zjuY1v7pMnuo8KnRIIJcW6BfCcdwavX2E5X+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Qh7/ev91c9oJZJQGWoHZ0O0NHgNenRWxmUI6qDE58pQLYP4zSYmH893k6CsoEOcmLTfCXprGVOcQMnZFlsZ63Qo+MABl2VKabRAP2eVIuF64K5lm/ika6Z4eoQbEYD1zNx+0AWgmMHH2ibrejbHdsCgk8KGYtnuK+35iWAAMeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=httIURWE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="httIURWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791599053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BwRaFJ+DN/5IpD5k3YQNzjqChDQKihsvzXSjQDC/yM=;
	b=httIURWE+pQiDqRkV34mKQsaC9kS0ofEOza4C5F7e71IXYpajRArRoshmuiTU4r1E+QNZj
	nRgG9hZwDv0Ox4QsYZTU8VTAq4wy2pVzQ7iGr0FwpDXRjhYt3gEN7LA38Dge3ZBHhKSFnl
	6aDDFMg5dnL2M3VriZseONpMGLVPMys=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-XC1eVpjnONSoC5syjC2akQ-1; Sat, 10 Oct 2026 02:24:12 +0000
X-MC-Unique: XC1eVpjnONSoC5syjC2akQ-1
X-Mimecast-MFC-AGG-ID: XC1eVpjnONSoC5syjC2akQ_1791599052
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5339732335dso5410941cf.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 19:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599052; x=1792203852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4BwRaFJ+DN/5IpD5k3YQNzjqChDQKihsvzXSjQDC/yM=;
        b=dFtSG84F/nwIjyPS6NDr6TvyLqDtzpUR8HHS/ydTflPBUcwZKh9EsussZfdNUJlYDQ
         giLIX0DGek5T2CE7AQ+TzN8qjh4+qHaiu25egnCudOSiFhhXNtyxNk5Y5P2YEymk7jVo
         EqCrDUG0Brt8wMU1XMvS40CS7UN99K5repfXAIDVLSJj/p0cBplPuBAaNP8cfcXpLvKr
         zicDOE4hsPJpUyfhdEeisMRofPBdgvUD1+rGUv0lPqqZ053SDw4L3dE5jQGb35L2jXpo
         YDjV/wdu0a6zwIonGo/AhXUZJhV/Fw4fHGdggox6Zp6ZPGKTRxGfEXsch+c6dm1qWGdQ
         CxYw==
X-Forwarded-Encrypted: i=1; AKwUvBzTFsDIjgU5uaawZNdytpgTWEzdIsKhAxo/oFr7g9teBk5C8+19jicIE1rzyp65rb39mX8EyRrtKeDc9eNS0z19Gqs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIp/JFOmt5EB2LtDZdfTFXfjPTPSt+lpOs9+/PUPbR6jEWBit1j
	egHNfikJgs8JIRRfZ+FadpOeuaAN4dCNitADwCgyVReHcc/GP4H9Ms3zqHN51paL7yjwATtphx6
	B91PWNzI2GgT9e5lAwdtAP1lCWsVy0aLhRVn3VtWwbMMufJKzLHjIKwvEjI/aHDHJdPKqnN0obS
	oEiCwSDQ==
X-Gm-Gg: AYBFou0udeeb5dHrKI5XNIi25HGwY/z/94UGYXWe8n8yuO5+bF2/7XhR5fw/en/PuoQ
	z3qAfxYoKoJ5iTBRt7Q8m8pH/esG5xeWOFhfu8JIev4hMoc/SsN2OHP8ddovCtJP+UKL+GRscqY
	lKA8APF2s0EfG+y+oC5pZMHEZ6s4gun00GxF7eNlH6HP/3GuxFyYrIk5Hm2qUAzZ6fWWlpIuDt4
	ppmAdOXXj3XDOm5o8WvrESsk6ALys619MoEr8aQKfh8LVfJmQvIZi5VEd5Vt2ubSCz3tEa+RmXr
	8BqeymZOutcn7MDV1F/XJq840+ApRTaGs6XRK7AFSnQtFYWBbfK4A/SSQcscZj1cY2/SCV0miks
	II4tEWM4CI+hCs8p6lfMU/NP2+eQ/COvYj/y8wd6Nz/lAi7U1F2DgJsU=
X-Received: by 2002:a05:622a:4c0f:b0:535:384d:68ac with SMTP id d75a77b69052e-5359facfcbamr58212131cf.13.1791599051631;
        Fri, 09 Oct 2026 19:24:11 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0f:b0:535:384d:68ac with SMTP id d75a77b69052e-5359facfcbamr58211921cf.13.1791599051146;
        Fri, 09 Oct 2026 19:24:11 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7c0214sm31284151cf.25.2026.10.09.19.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:24:10 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 9/9] tracing/osnoise: Refuse timerlat fd open if tracer inactive
Date: Fri,  9 Oct 2026 21:23:38 -0500
Message-ID: <20261010022338.2507589-10-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010022338.2507589-1-crwood@redhat.com>
References: <20261010022338.2507589-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HrLa90RgnIwAYlHso-culdTTpZRCeaLmfNSn2o_YKcw_1791599052
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
index 912ff5f5e490..fc55ef8e7204 100644
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

