Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190C25B0B7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772105; cv=none; b=EgiIqd2tyoy+a3HlYuN9G8ur7EktpfkXKD+XtNbuBPHgegA9MroHZWC2xPN3nmpwthEXlo/Wj2e+uu6dZDSPcm0dIQz+6TUswWgz2idtBzATqsLtEkwN7O/oCyiyNs08dNWmRKQRzQAp51UY2YW9TLAMCSU2eB08BKItalHNZmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772105; c=relaxed/simple;
	bh=t4pf0tnESEA/39/+VmiJIbTN5OWd2wrRcu4MCbnbWEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=C5h7+19bEOyDxNl/Qg96exAF3ykrhez0R144wq687MvFlayZGsiTJwdVM+ZL0RkP8YnnWkXC5LtnX6dklsfFA5hQnRb6//JJiFyDhFXT9K/fsIPDxCviTGwZmJO2/YaWPeT+/glgzupOChhjiUJee85nMNVBO9jbFPERntcphPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/S0PYT7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/S0PYT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778772102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ri7ot+VccVROE2i09PVPZkiJRxbE0JkHy/+alxHnvTM=;
	b=E/S0PYT7JH/Ac3ejVSWPJaWbqbyc51v7iJuypAOkhzgiGLInNrrrX/OqBGLPr9WZc3Mttd
	NhkI2+lv8qIBW2upR5287HfYwse0DumEIMgphbSByuYhRWa7rUFp+3QvspY6pbl6nI09cU
	2HUpl4iQsYCJsTMJT3vG/r+06EuKsvo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-LVeZs8IEMZifofwOARVfWw-1; Thu,
 14 May 2026 11:21:39 -0400
X-MC-Unique: LVeZs8IEMZifofwOARVfWw-1
X-Mimecast-MFC-AGG-ID: LVeZs8IEMZifofwOARVfWw_1778772098
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39ECA195608C;
	Thu, 14 May 2026 15:21:38 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.48.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 713FD30001A2;
	Thu, 14 May 2026 15:21:35 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 06/14] verification/rvgen: Fix options shared among commands
Date: Thu, 14 May 2026 17:20:47 +0200
Message-ID: <20260514152055.229162-7-gmonaco@redhat.com>
In-Reply-To: <20260514152055.229162-1-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: qsZw4pH8u62aG1WNrLJV64WeHPwugUaTTUt-V4aLA7Y_1778772098
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After rvgen was refactored to use subparsers, the common options (-a and
-D) were left in the main parser. This meant that they needed to be
called /before/ the subcommand and using them without subcommand was
allowed. This is not the original intent.

  rvgen -D "some description" container -n name

Define the options as parent in the subparsers to allow them to be used
from both subcommands together with other options.

  rvgen container -n name -D "some description"

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/__main__.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index 3be7f85fe37b..5c923dc10d0f 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -18,14 +18,16 @@ if __name__ == '__main__':
     import sys
 
     parser = argparse.ArgumentParser(description='Generate kernel rv monitor')
-    parser.add_argument("-D", "--description", dest="description", required=False)
-    parser.add_argument("-a", "--auto_patch", dest="auto_patch",
+
+    parent_parser = argparse.ArgumentParser(add_help=False)
+    parent_parser.add_argument("-D", "--description", dest="description", required=False)
+    parent_parser.add_argument("-a", "--auto_patch", dest="auto_patch",
                         action="store_true", required=False,
                         help="Patch the kernel in place")
 
     subparsers = parser.add_subparsers(dest="subcmd", required=True)
 
-    monitor_parser = subparsers.add_parser("monitor")
+    monitor_parser = subparsers.add_parser("monitor", parents=[parent_parser])
     monitor_parser.add_argument('-n', "--model_name", dest="model_name")
     monitor_parser.add_argument("-p", "--parent", dest="parent",
                                 required=False, help="Create a monitor nested to parent")
@@ -36,7 +38,7 @@ if __name__ == '__main__':
     monitor_parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=True,
                                 help=f"Available options: {', '.join(Monitor.monitor_types.keys())}")
 
-    container_parser = subparsers.add_parser("container")
+    container_parser = subparsers.add_parser("container", parents=[parent_parser])
     container_parser.add_argument('-n', "--model_name", dest="model_name", required=True)
 
     params = parser.parse_args()
-- 
2.54.0

