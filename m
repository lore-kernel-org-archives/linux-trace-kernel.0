Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AB337A3D1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835380; cv=none; b=Rub9rkjctg0hhT6QBXwG0lGLyh0iWmcvTRhFlSBCJQATnxINc7UKS9ywr0+MPMkPbIpRpo98ai9mK8nA6t0iemXlkVuXCyxw0p1efMOHqkmo42A56Mg81N/0AFj1rPS2fYNhTTXnFLxdqjdZ8VVe+V+vJxE9etmtdZLlqJB80J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835380; c=relaxed/simple;
	bh=W7F6ofQm9i5OMHMEQLNobUycQ6FyyZZLSn2Kgq7fZWE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=eTNqAXMVBbPokZDJPK+dqDvaEPNT1FgZRgiycHtBh005zq62EzN3/ChgFg1gEjc7yXdOAM1M66wpyq/jWeuEO6z91XG6tmsAxPYoioLlC78lWgLlLZcewhLlhrJTPzGiBf/bSlximgM57NoP+Hf3LcDjZms+OfxI3qEgByHwd+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOBk3NKZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOBk3NKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761835377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7RBY6cRsphyM7Egk+QxIKUUG4SJbeGL2Q7A3V4twLHM=;
	b=SOBk3NKZ+iJk/qv3BaqVLH+0WrD9mhriULy8+iMeHggpqY3pLQH7OzBJ8rIy8jU2lPEzSu
	rc3fZpXwwN3RrcdURbvYqbQYv61wwatJ4f2cJQMpTdle28P4qC6ZOXNpO0tVuDFwszmOrx
	WKHWKtkFdmBYjUw3TvESSVoSZqX6nxY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-TeZy8KFdNhKxn1S4PSezKQ-1; Thu, 30 Oct 2025 10:42:56 -0400
X-MC-Unique: TeZy8KFdNhKxn1S4PSezKQ-1
X-Mimecast-MFC-AGG-ID: TeZy8KFdNhKxn1S4PSezKQ_1761835375
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4278c82dce6so678663f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761835375; x=1762440175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RBY6cRsphyM7Egk+QxIKUUG4SJbeGL2Q7A3V4twLHM=;
        b=R12vob0hgbZueVaC/ZK5/tT+5AnJGDF116espMRY7R28GR1z0O+iId0P+UoO/+kbAa
         +qgd3MdwGpUUt6+fecEr/jzsdaUXsMQxsje2k5K0RJdldAnTDEFeeF060/0dxVDuG3k+
         PI32w10D4OF3jbw1UA96cPuInoinjZQ/ZIlQPR+eIT700fItcRM7GeE6RViO8/disLeq
         RPTxRZi3Io6RNNbzw8kNNDltnrNDoRjyejN76p5ulmyFvRw00TSUnYzhxh74/1/Z//J/
         mJ2zdH+Cfk7I1UNcgSa9ntY/1i7zZxQeeZQSOanqFbzf5e/z8AckPMozBmNGgK/FoiQX
         6Adw==
X-Forwarded-Encrypted: i=1; AJvYcCWdCtG6SYPWNIF6mQlSKXXlSwsBrtOdq1j+2Wxbq1K/TGuKzIFW8JrQipT/dhg8nos76hjlO3krfdwLHO33Qw/WdwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfvyi2RmHWwKgN0p4gpvBjHNUTza9jMZ2vCEsQ3ehcd7GFgPq8
	1Zfx34RZ+z9Ku5Wu+pLCqr7juMBYdi+JO9vPLP2VmCCys1Xm+lFeQzBHVcmHKDYpIUk44hjmjtV
	yLSCtZDcLlZWHDtEzNJGi0aWNnjK3gdiroZPZJXwcVbWPFL9hynRXjxEdGFFV0PPxUp15To217g
	==
X-Gm-Gg: ASbGnctCwB+jlG5WzSsbnjU4yej1G1vzlDq0XRHWHzUSC7uaFCs65U6JdBmKTF7bqeJ
	w6MMe02u4CFYmssBqpyYkircW9BRJCtEYP8rWXYCgFWk20Dgb3TiK1TZsiyUrVH/opPKnNXMkPL
	m0hy+DyI2mEzee9zWjjyh2+ZU6YvyFNmqbvdtsRtU0tBIA0+4H/uwzKujLLYvasZwdUcNgpU9zI
	4MDbRGkqT69prdahGbyIZdzL/g0aQMmtvqC2nYFn+S/b28Gb+H6RrxXbCgr7kT/SpAacwMvvVxr
	l0byR/gbZboF8+eskw1NDDe1++A4a51z/ZeWwdQuPiYA+hp58BuU5ugM/S3n9FnbL/gxRdsdhe1
	WyhTKuWTG50pgWQF5
X-Received: by 2002:a05:600c:6215:b0:475:de05:661f with SMTP id 5b1f17b1804b1-4771e3cb787mr59234015e9.41.1761835374700;
        Thu, 30 Oct 2025 07:42:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHCgM4Ds9xAAPOUDu/AHE+PrtojCrX8DIjSrcBE/xzmmspk1K0VbazsEIkFHo7lgNZdGqN0A==
X-Received: by 2002:a05:600c:6215:b0:475:de05:661f with SMTP id 5b1f17b1804b1-4771e3cb787mr59233795e9.41.1761835374271;
        Thu, 30 Oct 2025 07:42:54 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e294:5000:b694:8e49:4f51:966d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289b396dsm42970075e9.11.2025.10.30.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:42:53 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Extract cgroup common code from set_pid_cgroup and set_comm_cgroup
Date: Thu, 30 Oct 2025 16:42:28 +0200
Message-ID: <20251030144231.40058-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BI1yWGU0-RONBWiZb4U_jlme0ZjJcd7GBfoal0tKbIQ_1761835375
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The set_pid_cgroup and set_comm_cgroup functions have code duplication
for opening cgroup.procs file.

Extract duplicated code into a new helper function open_cgroup_procs().

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/utils.c | 68 +++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index d6ab15dcb490..fcd8ad98551a 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -769,27 +769,24 @@ static int get_self_cgroup(char *self_cg, int sizeof_self_cg)
 }
 
 /*
- * set_comm_cgroup - Set cgroup to pid_t pid
+ * open_cgroup_procs - Open cgroup.procs file for writing
  *
- * If cgroup argument is not NULL, the threads will move to the given cgroup.
- * Otherwise, the cgroup of the calling, i.e., rtla, thread will be used.
- *
- * Supports cgroup v2.
+ * If cgroup argument is not NULL, use the given cgroup.
+ * Otherwise, use the cgroup of the calling (rtla) thread.
  *
- * Returns 1 on success, 0 otherwise.
+ * Returns the file descriptor on success, -1 on error.
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
@@ -797,7 +794,7 @@ int set_pid_cgroup(pid_t pid, const char *cgroup)
 				sizeof(cgroup_path) - strlen(cgroup_path));
 		if (!retval) {
 			err_msg("Did not find self cgroup\n");
-			return 0;
+			return -1;
 		}
 	} else {
 		snprintf(&cgroup_path[strlen(cgroup_path)],
@@ -809,6 +806,31 @@ int set_pid_cgroup(pid_t pid, const char *cgroup)
 	debug_msg("Using cgroup path at: %s\n", cgroup_procs);
 
 	cg_fd = open(cgroup_procs, O_RDWR);
+	if (cg_fd < 0) {
+		err_msg("Failed to open cgroup.procs: %s\n", strerror(errno));
+		return -1;
+	}
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
 
@@ -838,8 +860,6 @@ int set_pid_cgroup(pid_t pid, const char *cgroup)
  */
 int set_comm_cgroup(const char *comm_prefix, const char *cgroup)
 {
-	char cgroup_path[MAX_PATH - strlen("/cgroup.procs")];
-	char cgroup_procs[MAX_PATH];
 	struct dirent *proc_entry;
 	DIR *procfs;
 	int retval;
@@ -851,29 +871,7 @@ int set_comm_cgroup(const char *comm_prefix, const char *cgroup)
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
2.51.0

