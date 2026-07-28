Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAE241A515;
	Tue, 28 Jul 2026 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231963; cv=none; b=eE1ul99ohNgrSnrxTCuzJKVfi2u0K6OImuBQ0264CXdRTUvXpZtqp/chLu64RHfQb90wlkT6Ct7aBcqai7bv5yKWL7Oih12d1sXdo2R78K1Irpu+R2qF3YP4XnDiAanPyVrV6BaofPShEYp1Vga5CNCKSHQBNoPxR8eic2VG/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231963; c=relaxed/simple;
	bh=H42NG3V015nibKhRMa5MmicdofTlDR9xMbceVx+jxuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZZnnGnprROHWWf4pwdZxBjW0gjSdEdirY4MT1BQePPcF8geon9HzqwiZJcRMwfJzmAbG72wIN1B5xN4jVHt8aymqGblKeiUH7fzhFrstmA9GbdcixRRQG+bdq1ZVeExUFmL/AT/zfHsc5x6lDkSWAGKWa7CVNSDjqHkSE41ceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K1yp/Imu; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K1yp/Imu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=o3
	TDLIwQvjZ8TtIEIny4ogW0OsMtkKq/C1IpdJJVWXo=; b=K1yp/ImuQUDNwMp2JN
	cBtGtMeMfDNM4kLzcYGmviWTAFFpB+NePb/Zgm6eejx6CDUlHCF/n/XYe4tZfFtl
	XGcuLdPC7fLF2hmYd1QA6s9ZZd5PBhBzaCFa7Pg8PsvUyXpA/tdrnU+Vpjs2TWrs
	UVvwsiGktnBzpH+ju5Q5g76e0=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXFzUiemhq86rAJQ--.13303S2;
	Tue, 28 Jul 2026 17:45:08 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: almaz.alexandrovich@paragon-software.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	liubaolin12138@163.com,
	liubaolin12138@gmail.com,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v2 v2 0/7] ntfs3: add tracepoints for core filesystem paths
Date: Tue, 28 Jul 2026 17:44:19 +0800
Message-ID: <20260728094426.749482-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXFzUiemhq86rAJQ--.13303S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrW8Kw13Zr17XF48Cr4fAFb_yoWDuFg_Wa
	4xKayktryUWFnFga98Gw17JrWIkr4Sqr1DJFyftF17XFZ8XF4rJF1vqr43Xr4Igw1YqFn8
	AryfJF18Xr13ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM8nYUUUUUU==
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwQRcJ2poeiSICgAA3g

From: Baolin Liu <liubaolin@kylinos.cn>

This series adds an initial set of tracepoints for ntfs3 core paths.

The tracepoints cover:
  - mount and log replay
  - namei operations
  - directory index operations
  - allocation and block mapping
  - iomap operations
  - file I/O entry points

Changes in v2:
  - Drop the redundant name_len field from the ntfs3_lookup and
    ntfs3_create_inode tracepoints

Baolin Liu (7):
  ntfs3: add mount and log replay tracepoints
  ntfs3: add namei tracepoints
  ntfs3: add create inode tracepoint
  ntfs3: add directory index tracepoints
  ntfs3: add allocation tracepoints
  ntfs3: add iomap tracepoints
  ntfs3: add file I/O tracepoints

 MAINTAINERS                  |   1 +
 fs/ntfs3/attrib.c            |   9 +
 fs/ntfs3/dir.c               |   3 +
 fs/ntfs3/file.c              |   5 +
 fs/ntfs3/fslog.c             |   3 +
 fs/ntfs3/index.c             |   8 +
 fs/ntfs3/inode.c             |   7 +
 fs/ntfs3/namei.c             |   5 +
 fs/ntfs3/super.c             |  11 +-
 include/trace/events/ntfs3.h | 389 +++++++++++++++++++++++++++++++++++
 10 files changed, 440 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/ntfs3.h

-- 
2.51.0

