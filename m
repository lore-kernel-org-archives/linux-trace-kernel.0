Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA93161B7
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186804; cv=none; b=dH4A+H8/7MYvku5XcOPREs7Wo+hajcZJxiX4sM1ZrDyZdF9Brc2yuS8MiY17HY60eKeOtuZXoMucjiJof91P+IIOaVOUxgC1lFkN0ipTe9+a379VPK3+UycP43PrO17aB+IfUe4XfHSDJKjwDe/1V7RFVQKJyewmda/RFYKOOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186804; c=relaxed/simple;
	bh=mNCO7bKF1YLZWJUvv6QucWgagnW9KRRy5Z/VQ4WsXkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uV7/G373JAsfW60KXPD7gRQBBuAjisZQbANiFlZ5WRPoEuWH9Rh4QLrDS+5CHKH+PUU3DLsPydF6JuxwW/WhpKmMu5chGSb0pSa/aRzlzW5PetSaNt2EOa7UIS241Pcyq3zmVVQGw0ChT97mprtwbaZFDp6EFhl07X/d6DEAmS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP7ygsWI; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP7ygsWI"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed101e8486so62702501cf.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762186802; x=1762791602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stkcD7bp9eEScodaC0wp9S9uIOMbzo7VYqM5npEhDuo=;
        b=YP7ygsWI4uYnEBFXIWSJReTo1vPTr2AmE3ku8YVokpGmde+rzBe42cA8nU5qjclEwR
         qH4Y1IKSb/KKmuw5YJGeO+rVdUpm8FZR3GWBRXcKwTWSxL00JIFFH6lY3c4aTvxw8fZk
         TKa/MDue6XsPkJc5jLicI3U1QjvVjsfYfYagi2W7hzj8wvbojBbBNkK6C/6s0g8C93x+
         nixx86mERz42qzzxDxV0sbHPEV4KFuS4rOAlT4bF+fgKkBm987UcpSWLolgBTHB0eVYj
         K9R3Fz1C5P/7lXcF6JHXPjHi3VjlqNx3ZAPgIq5VFTWkQ48wXqqpxCNYQf0GoyxmjceF
         1jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186802; x=1762791602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stkcD7bp9eEScodaC0wp9S9uIOMbzo7VYqM5npEhDuo=;
        b=WzoAm3PVWZlRrW63Oy8BK2vMCc4eXNBRKzH3K7Nxe8COZF5Vfht/P5fjVlPreHJIYl
         VnrAuwDEcbMN1qaqD58IM8MvwLyxtus1rqqeRCcg1kt/5Y9otftL/VCWbm5S6S3md23u
         zkmsBv5e/a7yMWVTQV5yzYuTp9g5EYj3dbsJYUKDZOvS3Wza87oX5hb7bTAH25S6O4Bd
         YcYw6GKxHwZn8Igmje9KQzp0E8rXMu2ocjF55xDaBHrv4B2sYiAdnES8AIeX7bP1pbfN
         M68UCLbvWxYcWKeWWt7fXBhckulYteJCHxrel+8s+SGf0e2EpQBIfp2RMWTuGw+IJUpA
         E6hg==
X-Forwarded-Encrypted: i=1; AJvYcCWnQIpU6lPnZNu4imQC/cH+FiUxwmU0zdBgLsi99kd1eAeRL8dqXO9l9SavJ2mBY1uQYKWbOZ1uDzc8jUY2X0G+c6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIJQme7P+gZMbmSQoOLwFiGQI+0icBBNzOFNbatR/yKvPAplAr
	b3X8IYWQgSpxFM7I4pmU7d0aqTaxlV3gZwyhkXx4L74EijpJC26JPex/
X-Gm-Gg: ASbGncv5AvF6O6rAShvms3OwWshQYeKx5niptL92aOpdANTxCm9eLX8++ODkCel4L1+
	5SYTUYQbPqccJwtEQbLfYtcyhp4FDSMLT5GmPjVMvNO4ZnFuqvwg0IhlqCcYq2iEbh0/sng4xCS
	oy3mQ0lI+47HL5zbWe+NzHNS61ijxjeAZ4KqO+c35mCtHe1RRiH9j7wsyDF82nUfArnwNiHw+IU
	T3Yu6QrMh0RxbcLGlzcgu6+L0Cd3pTeRdL0gRbQjSMXSw7IZiUE29PK1RJlFSADNztxExcPMWNp
	HNfrBb779+ftkJ6CdJw+1FmgpcQG3JnIwsnXzkfP5wrT+FmOki5i4quyaT7eBt/m1XgCQ1Vo4Pm
	N/KMAKJ433bJ2FBZWC+SnF67A2skjVQze/BSogLFKAajFa0fBIwaqNo0OdlRWc2Nv0IIuUQWlG5
	pyxSYQu1bwsSr3VU8=
X-Google-Smtp-Source: AGHT+IGe1q09n9Y3T70y+bZseDCq548mz/zlbtRlwZW06qsqGJ+EAcKCvfGCZuP/HMHl9AMMVlN6zw==
X-Received: by 2002:a05:622a:989:b0:4eb:a33d:1f45 with SMTP id d75a77b69052e-4ed30dcd062mr185924351cf.33.1762186801557;
        Mon, 03 Nov 2025 08:20:01 -0800 (PST)
Received: from ideapad.tufts.edu ([130.64.64.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060eb3332sm4273556d6.60.2025.11.03.08.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:20:01 -0800 (PST)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v5 2/2] rtla: fix -a overriding -t argument
Date: Mon,  3 Nov 2025 11:19:08 -0500
Message-ID: <b6ae60424050b2c1c8709e18759adead6012b971.1762186418.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1762186418.git.ipravdin.official@gmail.com>
References: <cover.1762186418.git.ipravdin.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running rtla as

    `rtla <timerlat|osnoise> <top|hist> -t custom_file.txt -a 100`

-a options override trace output filename specified by -t option.
Running the command above will create <timerlat|osnoise>_trace.txt file
instead of custom_file.txt. Fix this by making sure that -a option does
not override trace output filename even if it's passed after trace
output filename is specified.

Fixes: 173a3b014827 ("rtla/timerlat: Add the automatic trace option")
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 3 ++-
 tools/tracing/rtla/src/osnoise_top.c   | 3 ++-
 tools/tracing/rtla/src/timerlat_hist.c | 3 ++-
 tools/tracing/rtla/src/timerlat_top.c  | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 8b12d8803998..ae8426f40f8f 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -557,7 +557,8 @@ static struct common_params
 			params->threshold = 1;
 
 			/* set trace */
-			trace_output = "osnoise_trace.txt";
+			if (!trace_output)
+				trace_output = "osnoise_trace.txt";
 
 			break;
 		case 'b':
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 0be400666c05..6ae7cdb3bdc0 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -397,7 +397,8 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			params->threshold = 1;
 
 			/* set trace */
-			trace_output = "osnoise_trace.txt";
+			if (!trace_output)
+				trace_output = "osnoise_trace.txt";
 
 			break;
 		case 'c':
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 16416192e432..311c4f18ce4c 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -878,7 +878,8 @@ static struct common_params
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			trace_output = "timerlat_trace.txt";
+			if (!trace_output)
+				trace_output = "timerlat_trace.txt";
 
 			break;
 		case 'c':
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index fe4f4e69e00f..3a3b11b5beaa 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -628,7 +628,8 @@ static struct common_params
 			params->print_stack = auto_thresh;
 
 			/* set trace */
-			trace_output = "timerlat_trace.txt";
+			if (!trace_output)
+				trace_output = "timerlat_trace.txt";
 
 			break;
 		case '5':
-- 
2.48.1

