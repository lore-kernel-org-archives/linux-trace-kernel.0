Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755AC42315D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772086; cv=none; b=sC+2rkNy/FCJw6lHw1Z4Ie9EL6lPoMWxBulCJz7x252gje8WiWmmCre58fq2EK1H0w55E8c2aFpKY/VtUmSKokhwlxScQmR5AIsvZntq0DcgyiHR6/pasqbvl+JJxm9HbuvFS/TtYCAB1OSZcc7QxUN6qJQQ+zL028apyB4rwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772086; c=relaxed/simple;
	bh=E+DSAUBgHEQsfyxM6Knh3+4qtmmADUuWkGc6CuPvfUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VwYSd7ELyZjYv9xf0Y5yDLvGKqTsuObEDK9yAkoFLFTU5ogfQSuPbGEWpkn2vOhrcEQL/NVYdeQTT8aKJs1MlC0Y4AtVeKWQsf/+5BqZ6iBtm8VkoW1yFI8gmofmr9hzotkbo6kesi0HWyu0cw542/16ZuXRY9LRBbkSL1fEB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFhCFU6g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFhCFU6g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778772084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vd1fF6aAyPNOBNzcj+Y3eMBsL+QM4FlzHARfaZk0mQE=;
	b=FFhCFU6gumjM8Z30mWgFncz3SAKpo15eWwnAurA9/Y9kyUYScymLSViD0ZfwCWFtGB+beO
	nBabh3lw54SmpjY51h6WSQh8AxSB+SBtiGPC2J0539OII0JUbJePcX7Zf5f3MyStlKJMbL
	6+KWtDM2np4aBb9XoaiCz+G73ZxwUrY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-RIula7KAOriklGyC7KJDAQ-1; Thu,
 14 May 2026 11:21:23 -0400
X-MC-Unique: RIula7KAOriklGyC7KJDAQ-1
X-Mimecast-MFC-AGG-ID: RIula7KAOriklGyC7KJDAQ_1778772081
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 895A61956089;
	Thu, 14 May 2026 15:21:21 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.48.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51D7C30001A2;
	Thu, 14 May 2026 15:21:18 +0000 (UTC)
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
Subject: [PATCH v2 02/14] tools/rv: Fix substring match when listing container monitors
Date: Thu, 14 May 2026 17:20:43 +0200
Message-ID: <20260514152055.229162-3-gmonaco@redhat.com>
In-Reply-To: <20260514152055.229162-1-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: oOM0o0BX5hnud7jOnZLhry2iv37eF-fDMLDJ7yhywnA_1778772081
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When listing monitors within a specific container (rv list <container>),
the tool incorrectly matched monitors if the requested container name
was only a prefix of the actual container (e.g., 'rv list sche' would
incorrectly list monitors from 'sched:').

Fix this by ensuring the container name is an exact match and is
immediately followed by the ':' separator.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/in_kernel.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index a200b63f4509..95adae321c11 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -193,8 +193,12 @@ static int ikm_fill_monitor_definition(char *name, struct monitor *ikm, char *co
 	nested_name = strstr(name, ":");
 	if (nested_name) {
 		/* it belongs in container if it starts with "container:" */
-		if (container && strstr(name, container) != name)
-			return 1;
+		if (container) {
+			int len = strlen(container);
+
+			if (strncmp(name, container, len) || name[len] != ':')
+				return 1;
+		}
 		*nested_name = '/';
 		++nested_name;
 		ikm->nested = 1;
-- 
2.54.0

