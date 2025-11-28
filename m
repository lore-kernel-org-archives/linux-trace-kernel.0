Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAEE23C4F4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Nov 2025 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764343131; cv=none; b=Hxy5kr1i+sRMQtOck0k1fbwSGTTPkiNZ1vVt1MLyA8rWVlwPDpW4uIxq4eqWQXqov7xiUvT95CZCqXJfIWCx9bwW164g28w7BxWylf0Hi24CTL256S0uKWvnAYAi0SkaTeAhwo9Adpr30VgFoMnppIacXGbLiAgQwiJ07pMYo9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764343131; c=relaxed/simple;
	bh=77vkR0+1JCLSlChPUV7mfgMnrTVHDOFl297gadUE40c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJHM8exX3BuF4PegbnZwtkbtECMDfTB4OoqpUQJlnl4MeQOGVQup/8RL306MwkJPc6O/RQMkQm/EgcJRqHwBybbRd7dga6ViK0BG5MjZwrOzMYqVyTSjyAWrBAZpIrmWtAESb6k5eAzgo29jcTW6g7FnnvYshHemdY/EkyL9Dn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vld9HZWN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vld9HZWN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29806bd47b5so11758285ad.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Nov 2025 07:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764343128; x=1764947928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qB15gwXBroqkrK/PKr7oQFDmRDy1z34ETO6NhfgHsEw=;
        b=Vld9HZWN/LIZDhgmPy0nKU4VeEWN8ZwtgJdDuy8HY1Vrq4GVkz0mxBMkewz0OYgg4U
         p7BhFhq+/a+EubimiWPsMx6osbX5V0iRJ9dHFLy+4ibOVTlH2HVd1ksLSHoY8QJsnrSn
         Qwoiu8j7jtUP3SmSjnVqvB20+Q1t5xW+7qRBSpEwOLRoOQhQaMDeLdHNipVKqQenqE0G
         yW8rWAUCu4KaO25oiCaEDxYm35+QC8SelfzRLyuJHbu+r57yBA9XnTjOHX9g5JKwSwvT
         67hOEQQgVnkCBeP/Q0BHFJaFlQlBmOQ2gKhZsiXAVpsz+npuerkwuIKUN3jMbTNZw3np
         /zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764343128; x=1764947928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB15gwXBroqkrK/PKr7oQFDmRDy1z34ETO6NhfgHsEw=;
        b=kaJHhfUoZOg1DgqfxgAjIbT2ITpOXTaudizU3+tQYEolG4spDMhHXPaECy7kHSc4FM
         EVmYZgs4TZs1mvgyOKC5HJnPrc6pa/ELzdyseC/y8ts6AD5qfBGLPT22GcLgN3E3B8i4
         K5StHlO3RFgKH5q29sp4W9d01PTfSkDehnoMop96RptEjtPx5suogh67QFArF7d85oOU
         YGTQ/AMOeMvxHxhuxI5pJcFcCPYcD0FsHie/qOm9pLlAfpFHYWXAxlGaZIT/J4V+gIIp
         7LE4xKa99Nz99GUczSJDs+e7rt/72aelBy7+fZbCSFGCKq9VehbhSYBnoIXln2uLc2m4
         VFVw==
X-Gm-Message-State: AOJu0YxOQ9zjuYovw/qXHCgHx0DM5X3EzmXnxJuSnx28oFrZKJkCPtbg
	kxzmn2Tlhpl0KWwa5nrYT0QL54PondvrYMG6HE65uXDjLyhxLAI/6/4=
X-Gm-Gg: ASbGnct+rzCx28qb5glKRLp8uTDaGdcECi8CqlkL0Mn6PbMsNFCh6fg4TctP7aOXih6
	f3/OD7p02xg+u4ufby0uxxlq5j/8NQRF7kq/Kss0wQE4MfSLpGfBWFQWidB3XLPq6u5ngvknwWu
	jzaWOuVnLfPZ/HX0ed73tf5ayCwVaSBIcYI0U2eYHZKjLJCCvjNE+tIBW2pxip6Dw1YtcVud+Gh
	93k49irmFEND2gg6kk2glWMqTeU0AD51+6/ed8yEUKn+Fin9Vm+kW6Lsu0z3UYj6jjp6xE/0CVb
	8gZ6SzLmLwPluL1GjakVbQ4fAJUXjE9U6eMCQMUoHeq4Uy4Xts4DLrmwKrBXkY/Wutf7Uhue7s4
	MJcSBY+HM7gvUN61F2kx0j5ns3U7H2Veh5fbuN0ek+h9v0qjFzpSp/i8OBY4QfzbfNhiEHlc1uh
	gTLrHgL7oF4WfQN/YNQJBMWr/6QMuF9mYzWrZ8sRYri4nmtw==
X-Google-Smtp-Source: AGHT+IFMZPGeYzAXlC4s7H1GRQcgTEvVdLdV7GOhi3U/+54OuO5WVgJO+4Ca80HXmsdLRnU/cszaIQ==
X-Received: by 2002:a17:902:ebc1:b0:26a:ac66:ef3f with SMTP id d9443c01a7336-29b6c3c2857mr249858005ad.8.1764343127369;
        Fri, 28 Nov 2025 07:18:47 -0800 (PST)
Received: from samee-VMware-Virtual-Platform.. ([2409:40c0:1f:b21d:eb16:b830:6608:73b4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fb2490bcsm5064944a12.2.2025.11.28.07.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 07:18:46 -0800 (PST)
From: Sameeksha Sankpal <sameekshasankpal@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sameeksha Sankpal <sameekshasankpal@gmail.com>
Subject: [PATCH] Documentation: tools/rtla: remove undefined substitutions in common_options.rst
Date: Fri, 28 Nov 2025 20:48:38 +0530
Message-ID: <20251128151838.7985-1-sameekshasankpal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTLA common options documentation uses several Sphinx substitution
placeholders (|threshold|, |tool|, |thresharg|, |tracer|, |actionsperf|)
that are not defined anywhere in the tree. This causes the htmldocs
build to fail with multiple "Undefined substitution" errors.

Replace these undefined substitutions with plain text or generic
placeholders (<tool>, <threshold-option>, <tracer>) to ensure the
documentation builds cleanly while preserving the intended meaning of
the examples.

Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
---
 Documentation/tools/rtla/common_options.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
index 77ef35d3f831..bd5a6f32f5bf 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -56,7 +56,7 @@
 **--on-threshold** *action*
 
         Defines an action to be executed when tracing is stopped on a latency threshold
-        specified by |threshold|.
+        specified by the threshold value.
 
         Multiple --on-threshold actions may be specified, and they will be executed in
         the order they are provided. If any action fails, subsequent actions in the list
@@ -85,17 +85,17 @@
 
         Example:
 
-        $ rtla |tool| |thresharg| 20 --on-threshold trace
-        --on-threshold shell,command="grep ipi_send |tracer|\_trace.txt"
+        $ rtla <tool> <threshold-option> 20 --on-threshold trace
+        --on-threshold shell,command="grep ipi_send <tracer>\_trace.txt"
         --on-threshold signal,num=2,pid=parent
 
-        This will save a trace with the default filename "|tracer|\_trace.txt", print its
+        This will save a trace with the default filename "<tracer>\_trace.txt", print its
         lines that contain the text "ipi_send" on standard output, and send signal 2
         (SIGINT) to the parent process.
 
         Performance Considerations:
 
-        |actionsperf|
+        Note: Executing actions during tracing may introduce additional performance overhead depending on system load, system configuration, and the number of actions triggered.
 
 **--on-end** *action*
 
@@ -110,7 +110,7 @@
 
         Example:
 
-        $ rtla |tool| -d 5s --on-end trace
+        $ rtla <tool> -d 5s --on-end trace
 
         This runs rtla with the default options, and saves trace output at the end.
 
-- 
2.43.0

