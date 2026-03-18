Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA43F0AA3;
	Wed, 18 Mar 2026 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849545; cv=pass; b=SaSqy5eMMRHHxcTYOileZ0Bw9yxtvh4Gil7qkaCuf3BT3H8Z6/D0v5J+larL7uS1hOOK0nJHoFU8wEL9PbJwhdojUDbyLQF6uTePcpqBWPJzw/dIHLgKlnvvV/q3GLbBaoMwIGMOUc0ee66nVfQTM9xbuhxDgB2a8jJ/5u25CJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849545; c=relaxed/simple;
	bh=+HcyomxWy1PQIKulCzswSpTqDLVvWX9DnDSaTU4aHTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mNYdNZZGL55+uJnzWMuCDB7o6vDjpxvtmK9oZdTtU0ppCtirgydApwdgow+1zlh0Uuw5nneDCLeTXr4Yxr0rVxy7a47FypE692mnzZm4I60tyl2s7gbV58zStAEOmSa1Eymz6o1Ge6BfRMD3zhVtliexK9Nlac9wNKfkSrbRBmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=h0c302E3; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="h0c302E3"
ARC-Seal: i=1; a=rsa-sha256; t=1773849530; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=REeDVP4WvRK5wlbSdNDeTPF7O+JtrJ0AyoOVS3vU9+azbERFEZ0ns+1FvfVKRxEMoUZT6kzrRjV70g9313rFLGSrrRvzYAx/GA0abT4Ww0FJW9HPXWElPO5IpUJ1tCU2eUTI9WGiNRvir3Td3Yv7N6KIkGaPpt7MXMvY9VTJKFo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849530; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UbvUiKNE5dMPXW4ssJeNT5xwiCR/C80CpZc0PY4IG5I=; 
	b=bVnuCv9zs3eJuAPckq4upKUezxbRuZLh4thXC4yGGwcOkmlUIYzcht92DiWFetjX2BMF+Vx1qwTgu77s2I1SgJTjIU2ZVdAQu0NV7BSbWnVlOQ8bi7NzpgXcQdU1KdzgTZKAwuWN2f9wPo2opURnkgDYmHb7Yh0qjXWrsSxlgEw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849530;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=UbvUiKNE5dMPXW4ssJeNT5xwiCR/C80CpZc0PY4IG5I=;
	b=h0c302E3nLeu3GqaITPguQFaI8sl4/kSAN1BXUTqaYiNkz5mK5BacLACWuFPG11w
	A7aYSZNrS0pUxrByW8TpcF1DMIg03LgxX1TcGQ6xRT4iDiIhhCe0p+clQ2KfTT17qrD
	MqODfibYoBufV+VHQeyUqB2TpNaILYyyBEV57ckk=
Received: by mx.zoho.eu with SMTPS id 177384952884282.67598424902326;
	Wed, 18 Mar 2026 16:58:48 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 0/2] bootconfig: targeted fixes for stable
Date: Wed, 18 Mar 2026 15:58:45 +0000
Message-Id: <20260318155847.78065-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Two bug fixes with Fixes tags, split out from the larger cleanup series
(v7 patches 9/15 and 10/15) per Masami's request so they can go
cleanly into bootconfig/fixes and from there into stable.

Changes since v7:
  - Split fixes (this series) from cleanups/improvements into separate
    series per maintainer request, so fixes can go into bootconfig/fixes
    and the rest into bootconfig/for-next.

Bug fixes:
  - Check xbc_init_node() return value in the ':=' override path; a
    bootconfig using ':=' near the 32KB data limit could silently
    retain the old value, meaning a security-relevant boot parameter
    override would not take effect (patch 1).
  - Fix file descriptor leak in tools/bootconfig load_xbc_file() when
    fstat() fails, and preserve errno across close() on that error path
    (patch 2).

Build-tested with both the in-kernel build (lib/bootconfig.o,
init/main.o) and the userspace tools/bootconfig build. All 70
tools/bootconfig test cases pass.

Josh Law (2):
  lib/bootconfig: check xbc_init_node() return in override path
  tools/bootconfig: fix fd leak in load_xbc_file() on fstat failure

 lib/bootconfig.c        | 3 ++-
 tools/bootconfig/main.c | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

--
2.34.1

