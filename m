Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE413A896
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178925; cv=none; b=TMBNzZTPddUtx28DwfEe1cwRHwLyIszMVBWepW6r/6Tt5ZsbVXqnGhSfluHVknZVr23DVk8rC2WcY/88ZbwlCe2AIqMJOdvboaMDSUz1gjLXfb9AuWaDuooQIk0IAJmVeEyKUYtN3b8oPqe7H6MYwFDlLnLtjq3gbMb3Q/sCUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178925; c=relaxed/simple;
	bh=Bl2qzzEHgpGdJKV0zGc3PMz9DFh7mAtoqj4IPeX/p/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eAnyIk2yMiF4wswwVzGElATk6yQHEOhvt6/WW4ZbvRS8jiH6vu+BsFA+shOkSvMK+19xmH9m4r2CfivvVVh8N987qEPKDebawjcroashmUVbyyyjGtqR34KGGcruVpLoQbgFubbxTanvjkm6zQ1/pBXC5aAojPFxY3Ju1pcR7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:beb3:bbd4:b9cd:84ae])
	by xavier.telenet-ops.be with cmsmtp
	id GBvL2D00N3rtkie01BvLdZ; Tue, 24 Sep 2024 13:55:21 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st48S-000Su2-Qp;
	Tue, 24 Sep 2024 13:55:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st48W-005iAg-MA;
	Tue, 24 Sep 2024 13:55:20 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] bcachefs: BCACHEFS_PATH_TRACEPOINTS should depend on TRACING
Date: Tue, 24 Sep 2024 13:55:15 +0200
Message-Id: <b8436d9d368d1436a2d7e156a879bac5e31a799d.1727178847.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tracing is disabled, there is no point in asking the user about
enabling extra btree_path tracepoints in bcachefs.

Fixes: 32ed4a620c5405be ("bcachefs: Btree path tracepoints")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/bcachefs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/Kconfig b/fs/bcachefs/Kconfig
index 5bac803ea367c034..e8549d04dcb8dd1b 100644
--- a/fs/bcachefs/Kconfig
+++ b/fs/bcachefs/Kconfig
@@ -89,7 +89,7 @@ config BCACHEFS_SIX_OPTIMISTIC_SPIN
 
 config BCACHEFS_PATH_TRACEPOINTS
 	bool "Extra btree_path tracepoints"
-	depends on BCACHEFS_FS
+	depends on BCACHEFS_FS && TRACING
 	help
 	Enable extra tracepoints for debugging btree_path operations; we don't
 	normally want these enabled because they happen at very high rates.
-- 
2.34.1

