Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6235830F93C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864177; cv=none; b=HlAecEvFigWyND5Dw3Gu7zIBoX14mYHZBSQ4TF/wsoAG65CR+W18fhiKvdbpBMlQoS+Ru3ocuFaQZZis+YQrk5tygcxQtlCfVOTXvc5DO7lYDqbjRe12FC9d2JAiOjjrrBBsNn84L3XPagUpWFZ2X3QXWufvJnLLH6S5hoRoua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864177; c=relaxed/simple;
	bh=p+D3Eg0BKQWyZJQJRybbBR91hPF08V1/L2VyA/w8Ej8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=inVUbJ+KWEAFOr9LM7hNmxRr6T58rh9BNvUUbb+OTxX9KJlS2OvIA2Ar2rU/SXvHCOAZsVaripwMrcGhJQrx7KmBTQdC8NgjcOmQkIwhOcyPht0pm7x45GOHg2Rn6nKYxBQq8aTd2P7HHSmkJXmE7cft4SGIGA3SnULjY0YNiVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVDM25bO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVDM25bO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZGFMHus8YoaDUQgv49h9/RSwMSUiJxNbxlWLqqVtB4=;
	b=CVDM25bO5Ot8Xri7OqX7wK3KxgFDeWsrJeNLI5JoZetpCWsHLs01CRsLgO3tQmVLM+Q/EB
	E6aUuLVshhjruZxv8KMAO7w4fn4szWuw60HVhfsXkNHCH2KhRj1ThbLzFv4nnjuRzsYuhf
	1K5bzZPiXVJ9LWoDN9zKHq4mrlCcPcY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-VHHKup8UPy6jBl8ce8ObKA-1; Mon,
 23 Feb 2026 11:29:31 -0500
X-MC-Unique: VHHKup8UPy6jBl8ce8ObKA-1
X-Mimecast-MFC-AGG-ID: VHHKup8UPy6jBl8ce8ObKA_1771864170
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31AE818002C4;
	Mon, 23 Feb 2026 16:29:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0ED36180066A;
	Mon, 23 Feb 2026 16:29:27 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 13/19] rv/rvgen: remove unused __get_main_name method
Date: Mon, 23 Feb 2026 13:17:56 -0300
Message-ID: <20260223162407.147003-14-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: oleOXNeJ3xNDMqfhVXieUVX7w_4UB_nVUG61NPOABlc_1771864170
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The __get_main_name() method in the generator module is never called
from anywhere in the codebase. Remove this dead code to improve
maintainability.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/generator.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 40d82afb018f5..56f3bd8db8503 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -205,12 +205,6 @@ obj-$(CONFIG_RV_MON_{name_up}) += monitors/{name}/{name}.o
             path = os.path.join(self.rv_dir, "monitors", path)
         self.__write_file(path, content)
 
-    def __get_main_name(self):
-        path = f"{self.name}/main.c"
-        if not os.path.exists(path):
-            return "main.c"
-        return "__main.c"
-
     def print_files(self):
         main_c = self.fill_main_c()
 
-- 
2.53.0

