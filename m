Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA5841B352
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216856; cv=none; b=Hc8VpZeC5srXy/DwL7e8/Ubn1KFViUYQsfZsI1fiwuitdFRNvWmeEuwDp3oOIjaVJSop3nfUm7MRq6PvVJDJO37Qvvf36ggiCh6eKO0IFyFKyA6FZWzWqypdZzZZiF468prYfjbFyoaX7bxdIkMQTnPocffZUNbsTDRTxZK6gfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216856; c=relaxed/simple;
	bh=/Gpqv79U2S00zo9a7zY7AaE+cnW02/ouX1T7f4+Ng34=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Pvpc6bXyQEVihCk/aa1qUrD63uWeIwiifQiISeUZCVYL3AQur2IiI/cj6F2gXWeKwQtzY2vUxYtke9TIVFvx0jOAakmr1ID8dndyRxBgxL6UcFB57c3m/zC6j6EMD8pT2fvUVd1bpg60U+smiD6bB0u6aXg939gTfa8aIKnxSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiloeZon; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiloeZon"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770216855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4sKMhVxePK4zfkjpLf50eQqIDuXbhhCmqVw0kSawiaE=;
	b=HiloeZonLpbtsZ4SQw0jD5t8Ez9SKgfJ7CkPM5k6AlWndYNPVfqCA2+//7by6Jn1a5gmCM
	w1WwOXmG/l0xWJ8oif4X4J2l9i2C1lCuV3rRUfdCZS7RsNmF2/g/1/LfLdRtRKVuMCxMzx
	Urdp9cn8zANMFYAwJgAOx/ddD8BjcpM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-ItxIA8W1OjaJs37lndZHLQ-1; Wed,
 04 Feb 2026 09:54:12 -0500
X-MC-Unique: ItxIA8W1OjaJs37lndZHLQ-1
X-Mimecast-MFC-AGG-ID: ItxIA8W1OjaJs37lndZHLQ_1770216851
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D1B21956052;
	Wed,  4 Feb 2026 14:54:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CD3730001BC;
	Wed,  4 Feb 2026 14:54:08 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 13/20] rv/rvgen: remove unused __get_main_name method
Date: Wed,  4 Feb 2026 11:42:39 -0300
Message-ID: <20260204144914.104028-14-wander@redhat.com>
In-Reply-To: <20260204144914.104028-1-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 3mm9imG2xaqtwWOs329HEo_Gmrub-mlhxVsbb1dVn-0_1770216851
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
index 31c454329e8e1..ef6c9150f50c6 100644
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
2.52.0

