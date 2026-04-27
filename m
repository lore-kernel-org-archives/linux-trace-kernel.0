Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C24330D4C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302743; cv=none; b=DswtuajUGA4k2l7GJgTPKBbY4BYF90Oigx6FtQzbK/2pPfJZ90hq3AjR5i16yCUj2Oj2yvrKq/WGxonG6PqRvWQItTpn/c4AMBVUxlqAAWnMt5tGbeYrGy3Fwfi/LX7GJp9l1g8TymH/bRlh59iQRA+sAafcSOPp9miIyIqZoww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302743; c=relaxed/simple;
	bh=LwZXcmo2Q8kGxa9XafO6NBYohIHs7+CpXx4TqgrXJHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VgU/8La9UAQkqzTuSKDiYH5fgE8OvpCaSk4PoeD3RC4L6CQeIYabv2bKsqUmxJPjPEABxEADW3o1QzJHSZl37qysUtkD8QKldX1m/nb1grZqoaBmMqQOh3X9AthPQCjfOPsLiXDOFB/UjX7ZrZ37RVflUReXOPYbJoIH0xcD6Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=asLXtKZR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asLXtKZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777302740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IysWWWGtQm2Ux9tPok2t215f6jp//BYQOA29Tyl6OIc=;
	b=asLXtKZRPCIzLMLidAj0CPt7aQFhoFIWgbXRKcVYVFqfeXV1pu33m1n2DCEY+PSt4I5BcN
	jI06Fgi7K1XwGMxfFP+EIrVyJSLPq/ygXwk+nX/UPZBdFZzOYK+aNc2AwV9Cf1hoD7Eeq4
	WuHSWF3g73HWFGc3pkvL7iSI0e7QemE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-WOCGMCowMnmjou8hzewmlw-1; Mon,
 27 Apr 2026 11:12:17 -0400
X-MC-Unique: WOCGMCowMnmjou8hzewmlw-1
X-Mimecast-MFC-AGG-ID: WOCGMCowMnmjou8hzewmlw_1777302735
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 651561800451;
	Mon, 27 Apr 2026 15:12:15 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 52524195608E;
	Mon, 27 Apr 2026 15:12:12 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH 06/12] verification/rvgen: Fix options shared among commands
Date: Mon, 27 Apr 2026 17:11:28 +0200
Message-ID: <20260427151134.192971-7-gmonaco@redhat.com>
In-Reply-To: <20260427151134.192971-1-gmonaco@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: jZCKqlUTAOWq4xd9cRtg45DdeD7PDZ3zs9vxwk9y6ac_1777302735
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
2.53.0

