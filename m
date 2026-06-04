Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA4742EEC8
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575138; cv=none; b=K69/gN2SR9H+1n0eSZMAXsnPZzws1QdUZMaQKWQxcTAotseUno2IenqEIosUfXDnaqyoSj8dlE9pCQj+hDHqkcWaKhZy5A81pHvhGGdV0t05PQNSsEBd3fbjHh8IxgDHJPeFsZvOd5M6McqLGNgQzzJs/H/TY3MDuczAkM3TqsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575138; c=relaxed/simple;
	bh=caCwuqVzsWKf5C7H8mNzR3l5siRj2q+Dc6klx4frKV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=KgVvYdwqXC6r1Zn6Sqom50NW6V1L3wggRa+ANEEwxuCAPfnQys6FxwITaL43fy73Ns0ivCPj2eGOOMd8N9CadQ0pIGXHL5pwMPHejA/GLKjgJxmyU9oOgZ6OxyTE+C8MN6PxblMUdWD1Na3SFbopWQZYqalIkB5n5wz5xquPucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxXjisvU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxXjisvU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780575135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7uHeI9SWHmVw0u2/IAVTENHKMN7RT0yYMgayaQTYARU=;
	b=bxXjisvUAThYatQYPsleo/Xm3Q++hum7J/F0M62F4ce3dYkySk+/uMt+q1GxVfHTej/R7Y
	3ycm0aS1WR7kSYu1liG1i1PZ4Fk7+KPjhR+WA+LQK5wBJwbb4ORQ9tYcabLyAbzU6CypMU
	eowFnzo3fQWRnMC84gXgIdOiuo8Kmt4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-56wiz6byNLmVEsocSF39kQ-1; Thu,
 04 Jun 2026 08:12:12 -0400
X-MC-Unique: 56wiz6byNLmVEsocSF39kQ-1
X-Mimecast-MFC-AGG-ID: 56wiz6byNLmVEsocSF39kQ_1780575131
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF5C4195608B;
	Thu,  4 Jun 2026 12:12:10 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58533195608E;
	Thu,  4 Jun 2026 12:12:09 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: unknownbbqrx <dev@unknownbbqr.xyz>
Subject: [PATCH] tools/rv: Ensure monitor name and desc are NUL-terminated
Date: Thu,  4 Jun 2026 14:09:45 +0200
Message-ID: <20260604120946.90302-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: XHPhE8NnqPUdDiwRDNyDu58ogfYFRYfY-WPXj0JHLkk_1780575131
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

ikm_fill_monitor_definition() copies monitor name and description with
strncpy(), but does not guarantee NUL termination when source strings are
equal to or longer than the destination buffers.

Clamp copies to sizeof(dst) - 1 and explicitly append '\0' for both fields
to keep them safe for later string operations.

Suggested-by: unknownbbqrx <dev@unknownbbqr.xyz>
Fixes: 6d60f89691fc9 ("tools/rv: Add in-kernel monitor interface")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

---

Patch was initially sent as [1], the original author's email address
doesn't seem to exist any longer and the author didn't provide a valid
name.

Reimplementing the fix and changing attribution.

[1] - https://lore.kernel.org/r/dc9ea036-de62-4e1f-be63-8e14d675bcca@smtp-relay.sendinblue.com

---
 tools/verification/rv/src/in_kernel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index 4bb746ea6..d32453824 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -215,10 +215,11 @@ static int ikm_fill_monitor_definition(char *name, struct monitor *ikm, char *co
 		return -1;
 	}
 
-	strncpy(ikm->name, nested_name, MAX_DA_NAME_LEN);
+	strncpy(ikm->name, nested_name, sizeof(ikm->name) - 1);
+	ikm->name[sizeof(ikm->name) - 1] = '\0';
 	ikm->enabled = enabled;
-	strncpy(ikm->desc, desc, MAX_DESCRIPTION);
-
+	strncpy(ikm->desc, desc, sizeof(ikm->desc) - 1);
+	ikm->desc[sizeof(ikm->desc) - 1] = '\0';
 	free(desc);
 
 	return 0;

base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.54.0

