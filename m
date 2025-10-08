Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D84C277C9B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953593; cv=none; b=f6o1VE0vVIX4ELe0VxFHh60DrqNqbGfW0pEoPdthgeQFuXEHYzMitAynqNKI6GW5tfe/HSkZ8dy7pk8csPxKCoRdk2DWZQBsKSd7aG7wbHBJELeQ+tyWZ4FDMwf4oa+Q6R+bVo4rahyEB4QYmZyW/pv6CakYv3EDuqelsBUFYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953593; c=relaxed/simple;
	bh=R01JDrYPf3T7tS3r0JRwFP7avSmaK3pXhJTdNJHaQRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=K4DuG1pbh+jHpIn0ocfuAGWzlBbxeQRrAbZGq671MymiCp/KsofzFgeOnCkKLtb+7XfwaphNp4ulTZyyy+5sCcpKsp4uy+JEEYmzPLvCdNhaoeG2PeR5bhmfAykXKUnSoHmXT4UZVL1ATSW7ek/FYcUrUYo0gNCYhgEjfBYmlx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGEUcZv8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGEUcZv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759953590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+sd0fKPLWAqOh4kQ/TQyBqgyJmAhPlQ/8KNnD12Elio=;
	b=fGEUcZv8v/R0wpRrCkPnoJyVQeCV9p4H8IqUJsOwEW8fkp8qyciHpZtR+X7aMhW6otXSsY
	cKWvWSmNJxmQEwMtV3py1ocfZGiElz6XApvjH+OLmxmaMeSltNBu6BOR37g81a+8jiITok
	2Yiat6Kb6t5eYcHEdeLUZA3iVJnDfC4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-R0r3TIV1PoySlJRYc8yW2g-1; Wed, 08 Oct 2025 15:59:49 -0400
X-MC-Unique: R0r3TIV1PoySlJRYc8yW2g-1
X-Mimecast-MFC-AGG-ID: R0r3TIV1PoySlJRYc8yW2g_1759953588
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so223773f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953588; x=1760558388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sd0fKPLWAqOh4kQ/TQyBqgyJmAhPlQ/8KNnD12Elio=;
        b=dWyX5Bn9Q8audtOoMvz27mvmVL3+EsuMEJC+aUXAvO3VKM3597XJbAw6AUCsSy0b2+
         eONb7LrhG0qZhla+n56GKFDjXreQEe/MS4pEgaKQqthe8Ote5FlajSK37oKcbR6Asy1N
         Ym8OBXvX6efJP3KM4t2vSfBST71Yn9uA3wf/w60V4Ai7CO931bUZGkdfHGiVH5uTIr2y
         5plR+jvYpn4CjLURWS6bIUCG81iznkSoPO56DqZHJE+hsp0AZSO1Se3INXZ6WXd+GG/l
         eTrLA40GqjExthwfAAneQ+ccdjOxu3JTk8HOYJU66JyDKshE4U4Ybd8aEmUYD7S3qbVs
         hE1A==
X-Forwarded-Encrypted: i=1; AJvYcCVlTDcuz/Lf76YVqPZvOvtA+7X8w3Aev3DRUSen2defELfivRSZlsY3u1ElaznAd3YY6IkudGEtnRIL4ELqaeGSkQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0tPcAszOFsKZp+gX/QDp9sNfiGOFwtyWAmejLhOrd+jPZxug
	+Rwh1Sfkezl/BBPHATz4OxgFpMzJ+FNFf27pGBKv4kW+2klLEoKL5RwVgIxeHLYbDuZnReOUxN1
	o+0ck4tj20La2ChifGKr/13gIh8w3/txJrQf4dleYgBQ25gTcmB0GVpRDag6e9U6cmbYL/MB00Q
	==
X-Gm-Gg: ASbGncv2YYsRLgBxUBKqzyVaoSlCKctyEQf0kDlY87wTn3bXT56D0EiyGYCQ5Pfb7Wp
	2ts/IrG7rwSRPLmfvhn5/uL4Ev1Ic8U7zccJFTird4zoYdD1NcMfQwayP0ypsXC4BXr8p9/T3rr
	H5X3/ng/oLNXVEJ+tdaXdwEUJgGX6TKboHuAmS0ORScbEXu/vQ0glqD2yR6tN1QOKN2saAt1edc
	VnL8Wpk3noa+ZeOthitz87wTawBHqLmB/p4R+G2bMQ8Du2dttLpw0WVDJzBm/EN16u+obEdccKh
	DgVhUIz4K3v+jUIBjjQj1Sd6FNOIdK3oLOd0ZW1lJ23dhRb0+ucoTVPW1d/xUvE=
X-Received: by 2002:a5d:5d85:0:b0:3d6:4596:8a3a with SMTP id ffacd0b85a97d-4266e7bf18emr3491662f8f.17.1759953586774;
        Wed, 08 Oct 2025 12:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEikjmlhNc/NKttcfoUG4lvNDzYLqq7gREx7dIbaipV6H4Hv0NV9ovVs6yS45bS8y/EUjzCng==
X-Received: by 2002:a5d:5d85:0:b0:3d6:4596:8a3a with SMTP id ffacd0b85a97d-4266e7bf18emr3491651f8f.17.1759953586318;
        Wed, 08 Oct 2025 12:59:46 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8efffasm31209583f8f.41.2025.10.08.12.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:59:45 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] tools/rtla: Replace timerlat_top_usage("...") with fatal("...")
Date: Wed,  8 Oct 2025 22:59:02 +0300
Message-ID: <20251008195905.333514-3-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008195905.333514-1-costa.shul@redhat.com>
References: <20251008195905.333514-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: utLOklx-vcYqA_8be9pa7KwJ-YGtmPcNj79hwX9QQCo_1759953588
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A long time ago, when the usage help was short, it was a favor
to the user to show it on error. Now that the usage help has
become very long, it is too noisy to dump the complete help text
for each typo after the error message itself.

Replace timerlat_top_usage("...") with fatal("...") on errors.

Remove the already unused 'usage' argument from timerlat_top_usage().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 32 +++++++++++----------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 03ecc38d0719..81b9c8c59c06 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -476,7 +476,7 @@ timerlat_print_stats(struct osnoise_tool *top)
 /*
  * timerlat_top_usage - prints timerlat top usage message
  */
-static void timerlat_top_usage(char *usage)
+static void timerlat_top_usage(void)
 {
 	int i;
 
@@ -524,18 +524,12 @@ static void timerlat_top_usage(char *usage)
 		NULL,
 	};
 
-	if (usage)
-		fprintf(stderr, "%s\n", usage);
-
 	fprintf(stderr, "rtla timerlat top: a per-cpu summary of the timer latency (version %s)\n",
 			VERSION);
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
 
-	if (usage)
-		exit(EXIT_FAILURE);
-
 	exit(EXIT_SUCCESS);
 }
 
@@ -648,7 +642,7 @@ static struct common_params
 		case 'c':
 			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
-				timerlat_top_usage("\nInvalid -c cpu list\n");
+				fatal("\nInvalid -c cpu list\n");
 			params->common.cpus = optarg;
 			break;
 		case 'C':
@@ -667,12 +661,12 @@ static struct common_params
 		case 'd':
 			params->common.duration = parse_seconds_duration(optarg);
 			if (!params->common.duration)
-				timerlat_top_usage("Invalid -d duration\n");
+				fatal("Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
 			if (!tevent)
-				fatal("Error alloc trace event");
+				fatal("Error alloc trace event\n");
 
 			if (params->common.events)
 				tevent->next = params->common.events;
@@ -680,7 +674,7 @@ static struct common_params
 			break;
 		case 'h':
 		case '?':
-			timerlat_top_usage(NULL);
+			timerlat_top_usage();
 			break;
 		case 'H':
 			params->common.hk_cpus = 1;
@@ -700,12 +694,12 @@ static struct common_params
 		case 'p':
 			params->timerlat_period_us = get_llong_from_str(optarg);
 			if (params->timerlat_period_us > 1000000)
-				timerlat_top_usage("Period longer than 1 s\n");
+				fatal("Period longer than 1 s\n");
 			break;
 		case 'P':
 			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
-				timerlat_top_usage("Invalid -P priority");
+				fatal("Invalid -P priority\n");
 			params->common.set_sched = 1;
 			break;
 		case 'q':
@@ -740,7 +734,7 @@ static struct common_params
 				if (retval)
 					fatal("Error adding trigger %s\n", optarg);
 			} else {
-				timerlat_top_usage("--trigger requires a previous -e\n");
+				fatal("--trigger requires a previous -e\n");
 			}
 			break;
 		case '1': /* filter */
@@ -749,13 +743,13 @@ static struct common_params
 				if (retval)
 					fatal("Error adding filter %s\n", optarg);
 			} else {
-				timerlat_top_usage("--filter requires a previous -e\n");
+				fatal("--filter requires a previous -e\n");
 			}
 			break;
 		case '2': /* dma-latency */
 			params->dma_latency = get_llong_from_str(optarg);
 			if (params->dma_latency < 0 || params->dma_latency > 10000)
-				fatal("--dma-latency needs to be >= 0 and < 10000");
+				fatal("--dma-latency needs to be >= 0 and < 10000\n");
 			break;
 		case '3': /* no-aa */
 			params->no_aa = 1;
@@ -785,7 +779,7 @@ static struct common_params
 				fatal("Invalid action %s\n", optarg);
 			break;
 		default:
-			timerlat_top_usage("Invalid option");
+			fatal("Invalid option\n");
 		}
 	}
 
@@ -802,10 +796,10 @@ static struct common_params
 		params->no_aa = 1;
 
 	if (params->no_aa && params->common.aa_only)
-		timerlat_top_usage("--no-aa and --aa-only are mutually exclusive!");
+		fatal("--no-aa and --aa-only are mutually exclusive!\n");
 
 	if (params->common.kernel_workload && params->common.user_workload)
-		timerlat_top_usage("--kernel-threads and --user-threads are mutually exclusive!");
+		fatal("--kernel-threads and --user-threads are mutually exclusive!\n");
 
 	/*
 	 * If auto-analysis or trace output is enabled, switch from BPF mode to
-- 
2.51.0

