Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1664687
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719535249; cv=none; b=ROUULHn37dGOhAST1L/qzrELZG87Eo+x8xlwYUZnWCvh4NhptHJOyabf7wXCsXfHtHYMkm+USsLhNJKEm26e2LinifNXlyNzDLYxu6YRvn7LK7hDUTaGKSRjoY8D6YvfHnLrhK+qVjvtzwOtqVkb4kH0DVxtgxomv6/MEXNDsAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719535249; c=relaxed/simple;
	bh=Xv8gun3l3UQeFDGlNKxjbcBxzvE7uW/YCpmcLt2vJf4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FnGUy29N2XZYBXBrGDOboWr7BxZlYphtxaQSBaYOC6yzvNXzLujoASpvJDPfHaXGzGGi1mQTHcfey5raLpUjE5m9Y4MnInoXsuYeGk3Vogscgvxs7AHPWGktmhDqrGcVfEzeAMrA1ytWWT08nJWA/Torg7wNMJBf1OK2TUhbiZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FisaPZHb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FisaPZHb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719535247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Unk1vGLR1Be3cNBuySBujecQ1IeVxttlaXhutd1cek=;
	b=FisaPZHbP09EdRhZsv003O3rvExgad1VXMS63QLaXlyh+kWBLauA4er41NI8vfAJiz6gW/
	2H2D6WV4k3xTizYMinPFrrUkZhD+TxniWVqo9rOVkrWToj3gGebtN4RImH4pPMdIpADD8B
	+8DtHTiw3/B5vK71wa0pioVlC8AilT8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-XXQvMnZLPSuCgEfhAsekdA-1; Thu, 27 Jun 2024 20:40:46 -0400
X-MC-Unique: XXQvMnZLPSuCgEfhAsekdA-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3765604de70so1268025ab.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719535245; x=1720140045;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Unk1vGLR1Be3cNBuySBujecQ1IeVxttlaXhutd1cek=;
        b=KPQyqeDlSco05Y48MX9E2+KznENTYXgqY/OBdTNKYCQC50SsVRAFzz9D1BmHqBqf1j
         pedMwABQ0oL7a0f8OqCLGeqy2W9RklifvxFM99k2m+tq9PDifDZ0oexL7v4OFi5vpknw
         dSb1dXDIMTIHTUysnPhrwCgrCHZ7mK5GPs0lABDxHxffZ1HSTSMZ2ft50rTv48UmG3fI
         8AGIzpIUTnN90NrPi0vKP3yhILgZJF4KKmijubGJjk0uOX30htD5VPr4+MDeklk68CNO
         cwoEP7+YT5R4lj+sDo9MaCyKxV127OOccUz0fn9X3Ni1MgneQvlaq7QUhtHy8gV0wYhw
         4XLQ==
X-Gm-Message-State: AOJu0YwbckDCQ7VzNWblWTKO2T7sXVWxzNf0T7F7Bqk9lZfowOAXmxww
	kT0VkhDApm1tDFMgnFNKGeIRu2PpegAVSLyTw0xZzEYpWBf722lCGsnc7a++qKWsL0t8/dcgLCH
	Rya+H43WvauShkZdtpY0/qKi9sdU9KizCeIUCl2TKRM3c4ftZPLfgc7hZs6ho/a7cpyrdYWFol3
	fqCA==
X-Received: by 2002:a92:c56a:0:b0:375:b381:9acb with SMTP id e9e14a558f8ab-3763b34fe73mr188912105ab.30.1719535245142;
        Thu, 27 Jun 2024 17:40:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh9UG4ASP/yXk4fz3eeE0HY6mTqWEdaPkoaUz2MCu4nPDeuH3H/jqqW6WuJ5Q6wUHkbfa/OQ==
X-Received: by 2002:a92:c56a:0:b0:375:b381:9acb with SMTP id e9e14a558f8ab-3763b34fe73mr188911955ab.30.1719535244811;
        Thu, 27 Jun 2024 17:40:44 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad2f41329sm1773545ab.50.2024.06.27.17.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 17:40:44 -0700 (PDT)
Message-ID: <6c9b0b16-e61b-4dfc-852d-e2eb5bb11b82@redhat.com>
Date: Thu, 27 Jun 2024 19:40:44 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 13/14] tracefs: Convert to new uid/gid option parsing helpers
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert to new uid/gid option parsing helpers

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/tracefs/inode.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7c29f4afc23d..1028ab6d9a74 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -296,9 +296,9 @@ enum {
 };
 
 static const struct fs_parameter_spec tracefs_param_specs[] = {
-	fsparam_u32	("gid",		Opt_gid),
+	fsparam_gid	("gid",		Opt_gid),
 	fsparam_u32oct	("mode",	Opt_mode),
-	fsparam_u32	("uid",		Opt_uid),
+	fsparam_uid	("uid",		Opt_uid),
 	{}
 };
 
@@ -306,8 +306,6 @@ static int tracefs_parse_param(struct fs_context *fc, struct fs_parameter *param
 {
 	struct tracefs_fs_info *opts = fc->s_fs_info;
 	struct fs_parse_result result;
-	kuid_t uid;
-	kgid_t gid;
 	int opt;
 
 	opt = fs_parse(fc, tracefs_param_specs, param, &result);
@@ -316,16 +314,10 @@ static int tracefs_parse_param(struct fs_context *fc, struct fs_parameter *param
 
 	switch (opt) {
 	case Opt_uid:
-		uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(uid))
-			return invalf(fc, "Unknown uid");
-		opts->uid = uid;
+		opts->uid = result.uid;
 		break;
 	case Opt_gid:
-		gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(gid))
-			return invalf(fc, "Unknown gid");
-		opts->gid = gid;
+		opts->gid = result.gid;
 		break;
 	case Opt_mode:
 		opts->mode = result.uint_32 & S_IALLUGO;
-- 
2.45.2


