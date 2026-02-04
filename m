Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1CB27B359
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216629; cv=none; b=tXMsMTmNsaixDOOSA/H09AptlsxB839FUmJxgwSHaQs4z1BfNcLBIIpCY5umkVtjB/jmZbEMHjxVt5ozmpAym+99vAvLaTI3wm8jXOEWUa9cezx4HzZqnaheC7HlSO/e3TDGRVXY0We6U61+uk5t5OQKgneucpLAmtBj+cfUbaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216629; c=relaxed/simple;
	bh=fs1Eb/BwH26KDZ/aWSModwgBQ1nMC3ZPEInp7b+m5+U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DKSKRidFbHJWi8AoXkNmo5ybqvkUX14ZKglckHc6gRmAiy56xsqpirRcRwkwKqIqt3abJNpNWczwOKYJ9McmoF4mv4ZXTrdF5mM1VPHwG1lPYeLln6YkZIRvymQ8v4FeNahS7ADyfeQHewbL4W1PcRs1PiixkqrtRPjuq+hYyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+ztPl/o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+ztPl/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ucfd3QhmcEvG5vsY6IAEUx/lDH1JMpNbncoTgo/FLFE=;
	b=W+ztPl/onkaBcCJe4eojXaMQndGRIyp8K/ff9IDNEoTrnnK5246ANpw913WZ0VkKGsyRD2
	h/0Avz0uqHqydwBqd4bnxP+wQbu/h5m68/ZT99jMYsy5qZ7Gy49wk33tEM96ytl3m1Rsaq
	eypaPQz5mHydCnvx8c1YFZo3aYdFWFA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-Mo4rgb_FNiaGyf2-2vwAaQ-1; Wed,
 04 Feb 2026 09:50:24 -0500
X-MC-Unique: Mo4rgb_FNiaGyf2-2vwAaQ-1
X-Mimecast-MFC-AGG-ID: Mo4rgb_FNiaGyf2-2vwAaQ_1770216623
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76E93180025F;
	Wed,  4 Feb 2026 14:50:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8F8530001BF;
	Wed,  4 Feb 2026 14:50:20 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 02/20] rv/rvgen: remove bare except clauses in generator
Date: Wed,  4 Feb 2026 11:42:28 -0300
Message-ID: <20260204144914.104028-3-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: Mft2LqgI8vLwfMBQdOZLfJdHXeex9LhXhbe5_Qg-lRc_1770216623
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Remove bare except clauses from the generator module that were
catching all exceptions including KeyboardInterrupt and SystemExit.
This follows the same exception handling improvements made in the
previous AutomataError commit and addresses PEP 8 violations.

The bare except clause in __create_directory was silently catching
and ignoring all errors after printing a message, which could mask
serious issues. For __write_file, the bare except created a critical
bug where the file variable could remain undefined if open() failed,
causing a NameError when attempting to write to or close the file.

These methods now let OSError propagate naturally, allowing callers
to handle file system errors appropriately. This provides clearer
error reporting and allows Python's exception handling to show
complete stack traces with proper error types and locations.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/generator.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index a7bee6b1ea70c..af1662e2c20a7 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -198,17 +198,10 @@ obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o
             os.mkdir(path)
         except FileExistsError:
             return
-        except:
-            print("Fail creating the output dir: %s" % self.name)
 
     def __write_file(self, file_name, content):
-        try:
-            file = open(file_name, 'w')
-        except:
-            print("Fail writing to file: %s" % file_name)
-
+        file = open(file_name, 'w')
         file.write(content)
-
         file.close()
 
     def _create_file(self, file_name, content):
-- 
2.52.0

