Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF13148D2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864298; cv=none; b=QjfcoBRHmQR/MrJdMPnc6QLDTBBws269vonCTsRRHqfyNR1WLY2oRbNCqEVoQ0I25S3weqyUf1Uy+ID/YRT0g0sOlo6BNgZZlQbUSK1Lp3ArtyrNw3QxL4AKg2Z6uiyu+5bTWMyX3dru2R8aiw47fsKWXk/GVkM3tnFLfNzhlN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864298; c=relaxed/simple;
	bh=KU9/4VAZzijQArIsaKiYpI841fkcKtb9bMBsovL0JqQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=eH7KLpbuOHne4UdDuZDf4WuYraYjYAHHlcAn2UxjxaPpEqbGwM9/73TgjQKuY9OoIo4jPhZ4GG0DgGOJ9BpdlpgIGn15K1+3ZFL3VarJPxti3QbtRUkA5ioYAhi5nbSx3oHeynjewf9YTfUs8Nc4fjyP0OD4PFDdlYGHoT9YBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dj7tSP36; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dj7tSP36"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dI23U9Hdos8EpUNnWdFryDt4BhqGz6vCVqX1QyTKn7I=;
	b=dj7tSP36/UJx05abCxEhVZE3Q/AAhhJjJRkOcRzcUt3/7crQOTwn3xkOVwPv69K34GbB86
	nvz/3pCP8EW9bRW/7ON2DS7gH83Nhcy8rezVOM6udVwM8vIeJ+zC5hPvd4Hvrmd1rVssxY
	c2al6ZPrI9KA0zzb0qtCRJbwlslqLV0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-12TAfljIONCEnDH90iwtBw-1; Mon,
 23 Feb 2026 11:31:30 -0500
X-MC-Unique: 12TAfljIONCEnDH90iwtBw-1
X-Mimecast-MFC-AGG-ID: 12TAfljIONCEnDH90iwtBw_1771864289
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5E321956068;
	Mon, 23 Feb 2026 16:31:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DB7E1800669;
	Mon, 23 Feb 2026 16:31:27 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 19/19] rv/rvgen: fix _fill_states() return type annotation
Date: Mon, 23 Feb 2026 13:18:02 -0300
Message-ID: <20260223162407.147003-20-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: lM5PRp7rvwWbu0jc1OThVjNZ44eJy1XEtP4Ri5y3LW0_1771864289
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The _fill_states() method returns a list of strings, but the type
annotation incorrectly specified str. Update the annotation to
list[str] to match the actual return value.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/ltl2k.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
index b8ac584fe2504..81fd1f5ea5ea2 100644
--- a/tools/verification/rvgen/rvgen/ltl2k.py
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -75,7 +75,7 @@ class ltl2k(generator.Monitor):
         if not self.name:
             self.name = Path(file_path).stem
 
-    def _fill_states(self) -> str:
+    def _fill_states(self) -> list[str]:
         buf = [
             "enum ltl_buchi_state {",
         ]
-- 
2.53.0

