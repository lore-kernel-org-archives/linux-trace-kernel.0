Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1977314A8B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Dec 2025 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580682; cv=none; b=XnOixrMuZXL5TK06nfiZ6iogj+zBbTQ8NwR9Vnaw6poPfwdQsrD8cuFtc22aijWC1XJEvk1O80uhGj67LJ5RlTskTzcwfFRC3LwOSDb/dojRaotITr2qVarrQrbcdRlAwcwM/qaBuTV5C4BZRqRHOE2qIG44kbGSr6bs6MdD8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580682; c=relaxed/simple;
	bh=dP8hT5Iu0RAejp/EVTjdBuZy8bVHWAsAm0/tcmV/4y4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=m2g93EeR4VrmgpuB16Uyoj7rx8rywK/7xwf0b8Vh4n3njHk7P+2cr3w0YV9qPyg1IfjUN6kBSGQ1CYSYkY44Tci3WY+gjtCW6vUipjMHCkOVApQZa7wo6fH9HbRt0ugrZBX7k+rSjIs8bBhbKoRyCa1DJDNwMJbkyJJSh//qNdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKKmMlGd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKKmMlGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766580680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jdolHyh9rh5rJ5MkRWABLiPIWLLCxDNdClFu6iuDitI=;
	b=BKKmMlGdg8Yv05N/D2lJgZ7Zv3NCSEnRT1aYp3azDaMsop5eqPbeP1MTxK6s6PIFG1Ob7S
	e1mJZdTtGfBIwG/c4bk1jlXNEX+AkpuKO68Td17I4bLFJ2T9sOFX9fEer1ARcJTmGOvGRQ
	IP8Q71d7xhPbsXS+P+H9kGdibPPt7rs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-izvWx_PrNTOLeCIW-JhXqg-1; Wed, 24 Dec 2025 07:51:18 -0500
X-MC-Unique: izvWx_PrNTOLeCIW-JhXqg-1
X-Mimecast-MFC-AGG-ID: izvWx_PrNTOLeCIW-JhXqg_1766580678
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d1622509eso32505125e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Dec 2025 04:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766580677; x=1767185477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdolHyh9rh5rJ5MkRWABLiPIWLLCxDNdClFu6iuDitI=;
        b=p8amG06Drkh3JNkUDHKu9+LvQncnbYQOIj7YSCyRln2+M/T1G5RZJYAIdxFsVG8g6N
         73las1WMHuH9UwphOKGku8iklp+MK0lAjY1gnDzDH8wrkVhVk6QyQrj7k8eOduexxSVc
         vGxAgAcZGv4proCrLLzgKCLB6yf2qnWSXQTgHpQ22X0Oq3ZObkPf/qMZ/QkcPsTRtzv/
         JsDvavv44IHjyGeUSS2O+Z0l2oNtrWBr657RaaCxA0R+enPaAB+3OEgSM6UZemMGCgE0
         KKYsxAsKjspJkEKXyGuaq0OC1i33eXkbAwwbdh/RqXj+HKQ+7RuagaoMYdLFUGfJGijG
         gqxg==
X-Forwarded-Encrypted: i=1; AJvYcCWNW3BaI2iQsa61itefoJrkvxnC6Vq/0jO8BUZWd4Lttz7PfL0pvKKniBACGI8BCPcKWQFEBUubOZa0P9fkneJEXeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWl6XBMccOd91qvw0Iq2QL0j40kEh+DsAvMgRM/HGEhApzFKQv
	BLaXzbzv+AQ/EHqPclbpqaTdFrGake2QfoFS1yv8xX7LjyJ2kBCNJZdos2IlwOmCaDaA+3N0rSG
	IfHFD30P8Yu5SSfaI89p1yR92c3l4TwU8mvG4O1eDJR1mwa150AgMBQ6kcGw1iEtpUsh9TCaapQ
	==
X-Gm-Gg: AY/fxX4QIng8V/2M6a8pb7jQJefCX8EuiONd3MW9I6OHdTVPwdTrEqSbZS13EUE2JoQ
	URXFtwHnMFKtC//apedRZk06CxAdP0mcjKZ22/6hT6/POpZaXsPzImRSoZtOjJDDP0H0znY8YNo
	4oMHgPstUBy1q5SGRNAwG5ET5bhgJmVyROoLKPS3KUxczPKAWZWNIO3VmCzL1qM9lmrfC3diDYw
	euLWpK7ro6ee/9TWnpQQPC/Tzi72Fo+2hTSYhNiU/sRsOaMf5lAISap2+4E1FG9OsPxflo7RVFC
	TmacbyKOst5BIfHYTtALtWwsUKDI801DcxJXxMsJYgt7kj9uR2WPsZNA6m+7FVXXNlDHIq5mIw7
	O/UA6qStV41FzB1IkzOGkFgTBPqQ=
X-Received: by 2002:a05:600c:c105:b0:47d:3ffb:16c9 with SMTP id 5b1f17b1804b1-47d3ffb184amr10424955e9.23.1766580677556;
        Wed, 24 Dec 2025 04:51:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf6nRlud3tbCmYPb3EeHZKF6Drkld0nQn08zBBkGr5/rtpie5AQr3WYCUYqGyri/LayKcyVg==
X-Received: by 2002:a05:600c:c105:b0:47d:3ffb:16c9 with SMTP id 5b1f17b1804b1-47d3ffb184amr10424725e9.23.1766580677104;
        Wed, 24 Dec 2025 04:51:17 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327791d2f3sm699415f8f.11.2025.12.24.04.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 04:51:16 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Deduplicate cgroup path opening code
Date: Wed, 24 Dec 2025 14:50:56 +0200
Message-ID: <20251224125058.1771519-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xvaMRF2DSUgdjVOQCxifhEkUqCXHRLxSxMastL2i-8A_1766580678
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Both set_pid_cgroup() and set_comm_cgroup() functions contain
identical code for opening the cgroup.procs file.

Extract this common code into a new helper function open_cgroup_procs()
to reduce code duplication and improve maintainability.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 65 +++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 9cf5a0098e9a..0b84e02b13df 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -784,27 +784,27 @@ static int get_self_cgroup(char *self_cg, int sizeof_self_cg)
 }
 
 /*
- * set_comm_cgroup - Set cgroup to pid_t pid
+ * open_cgroup_procs - Open the cgroup.procs file for the given cgroup
  *
- * If cgroup argument is not NULL, the threads will move to the given cgroup.
- * Otherwise, the cgroup of the calling, i.e., rtla, thread will be used.
+ * If cgroup argument is not NULL, the cgroup.procs file for that cgroup
+ * will be opened. Otherwise, the cgroup of the calling, i.e., rtla, thread
+ * will be used.
  *
  * Supports cgroup v2.
  *
- * Returns 1 on success, 0 otherwise.
+ * Returns the file descriptor on success, -1 otherwise.
  */
-int set_pid_cgroup(pid_t pid, const char *cgroup)
+static int open_cgroup_procs(const char *cgroup)
 {
 	char cgroup_path[MAX_PATH - strlen("/cgroup.procs")];
 	char cgroup_procs[MAX_PATH];
-	char pid_str[24];
 	int retval;
 	int cg_fd;
 
 	retval = find_mount("cgroup2", cgroup_path, sizeof(cgroup_path));
 	if (!retval) {
 		err_msg("Did not find cgroupv2 mount point\n");
-		return 0;
+		return -1;
 	}
 
 	if (!cgroup) {
@@ -812,7 +812,7 @@ int set_pid_cgroup(pid_t pid, const char *cgroup)
 				sizeof(cgroup_path) - strlen(cgroup_path));
 		if (!retval) {
 			err_msg("Did not find self cgroup\n");
-			return 0;
+			return -1;
 		}
 	} else {
 		snprintf(&cgroup_path[strlen(cgroup_path)],
@@ -824,6 +824,29 @@ int set_pid_cgroup(pid_t pid, const char *cgroup)
 	debug_msg("Using cgroup path at: %s\n", cgroup_procs);
 
 	cg_fd = open(cgroup_procs, O_RDWR);
+	if (cg_fd < 0)
+		return -1;
+
+	return cg_fd;
+}
+
+/*
+ * set_pid_cgroup - Set cgroup to pid_t pid
+ *
+ * If cgroup argument is not NULL, the threads will move to the given cgroup.
+ * Otherwise, the cgroup of the calling, i.e., rtla, thread will be used.
+ *
+ * Supports cgroup v2.
+ *
+ * Returns 1 on success, 0 otherwise.
+ */
+int set_pid_cgroup(pid_t pid, const char *cgroup)
+{
+	char pid_str[24];
+	int retval;
+	int cg_fd;
+
+	cg_fd = open_cgroup_procs(cgroup);
 	if (cg_fd < 0)
 		return 0;
 
@@ -853,8 +876,6 @@ int set_pid_cgroup(pid_t pid, const char *cgroup)
  */
 int set_comm_cgroup(const char *comm_prefix, const char *cgroup)
 {
-	char cgroup_path[MAX_PATH - strlen("/cgroup.procs")];
-	char cgroup_procs[MAX_PATH];
 	struct dirent *proc_entry;
 	DIR *procfs;
 	int retval;
@@ -866,29 +887,7 @@ int set_comm_cgroup(const char *comm_prefix, const char *cgroup)
 		return 0;
 	}
 
-	retval = find_mount("cgroup2", cgroup_path, sizeof(cgroup_path));
-	if (!retval) {
-		err_msg("Did not find cgroupv2 mount point\n");
-		return 0;
-	}
-
-	if (!cgroup) {
-		retval = get_self_cgroup(&cgroup_path[strlen(cgroup_path)],
-				sizeof(cgroup_path) - strlen(cgroup_path));
-		if (!retval) {
-			err_msg("Did not find self cgroup\n");
-			return 0;
-		}
-	} else {
-		snprintf(&cgroup_path[strlen(cgroup_path)],
-				sizeof(cgroup_path) - strlen(cgroup_path), "%s/", cgroup);
-	}
-
-	snprintf(cgroup_procs, MAX_PATH, "%s/cgroup.procs", cgroup_path);
-
-	debug_msg("Using cgroup path at: %s\n", cgroup_procs);
-
-	cg_fd = open(cgroup_procs, O_RDWR);
+	cg_fd = open_cgroup_procs(cgroup);
 	if (cg_fd < 0)
 		return 0;
 
-- 
2.52.0

