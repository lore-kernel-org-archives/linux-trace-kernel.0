Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D38E3B776A;
	Thu, 20 Aug 2026 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216817; cv=none; b=LIHRZS2VMPFWAhdlEcw7lzsRhi3v4WWkvu2+1N5IP72nqrxGZXF3Ms6B6O1WIv06mopJ54SzDK4pcSFtNKmgoo0SKgLxVMsQu3DxzCcgMiWpwbxN0TulYRO3e5vxz3zh10nl92peLpb9COLcLpoZhXiw3suSdKCUTdgZSGrNpBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216817; c=relaxed/simple;
	bh=HNcE/9s9LtJMh5rBQOJS6vBoWQ25dpqvvyeJYb4J7gE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CoGBSk0BFOToFgVENHKBBJOzEnvbsoZnKT8cE4FGcmShe2sY8qg7kPfbIGiykGk1DwW37ejwb50dNU8tmHuUH6epKko3waQ8LjbCgQrWmekGYx8RVWRrAzqwQ09UPfbaB75/VpAOmLji0tUGq0skW27sNgv87PwEkI6x29F1Sn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WdqToVQw; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WdqToVQw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=en
	rVbB0tlzxo2AvUQofyVixrsreHIn5CuB6ineVLbss=; b=WdqToVQwsq4up69vvq
	ytwUWacsznvtzMJPqfxSMgvp4foGpuDAypo93b1KT1GxG50fzpwKfl90dSmMskzJ
	ybmsRmOwbBbDVL9GX64VhkV+RV+AvtUKk0DlK6IV1am0yX2SgL6MBkT7CVY2I1hA
	kOG25K/jPT/Whi77FQsiNqfKs=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAHFld6w4ZqIRluPA--.45482S2;
	Thu, 20 Aug 2026 17:06:05 +0800 (CST)
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
Subject: [PATCH v4 0/7] ntfs3: add tracepoints for core filesystem paths
Date: Thu, 20 Aug 2026 17:04:57 +0800
Message-ID: <20260820090504.950475-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHFld6w4ZqIRluPA--.45482S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw4DCF1fur18urykZr15CFg_yoW8Ww1rpr
	ZxCrs3Kwn8JrW2ywnavF4DAF1F9ay8C34Ut34a9ry3AryFqr1xGry7Ka40qF48ArWDX347
	XFn0kr4UGFWUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJGYdUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwR1MF2qGw30oFgAA3r

From: Baolin Liu <liubaolin@kylinos.cn>

This series adds an initial set of tracepoints for ntfs3 core paths.

The tracepoints cover:
   - mount and log replay
   - namei operations
   - directory index operations
   - allocation and block mapping
   - iomap operations
   - file I/O entry points

Changes in v4 (both addressing review comments on patch 5):
   - ntfs3_attr_data_get_block: pass the "new" pointer to the trace
     event directly and move the "new != NULL" check into
     TP_fast_assign(), keeping that logic out of the call site and only
     executed when the event is enabled
   - ntfs3_attr_set_size_ex: stop sampling the old size with
     i_size_read() in TP_fast_assign() - on the truncate path
     truncate_setsize() has already updated i_size to the new value, so
     the recorded old_size always equaled new_size. Read the actual old
     size from the on-disk attribute record and pass it as an explicit
     parameter; move the call site after the attribute lookup so both
     resident and non-resident attributes are covered

Baolin Liu (7):
  ntfs3: add mount and log replay tracepoints
  ntfs3: add namei tracepoints
  ntfs3: add create inode tracepoint
  ntfs3: add directory index tracepoints
  ntfs3: add allocation tracepoints
  ntfs3: add iomap tracepoints
  ntfs3: add file I/O tracepoints

 MAINTAINERS                  |   1 +
 fs/ntfs3/attrib.c            |  12 ++
 fs/ntfs3/dir.c               |   3 +
 fs/ntfs3/file.c              |   5 +
 fs/ntfs3/fslog.c             |   3 +
 fs/ntfs3/index.c             |   8 +
 fs/ntfs3/inode.c             |   7 +
 fs/ntfs3/namei.c             |   5 +
 fs/ntfs3/super.c             |  11 +-
 include/trace/events/ntfs3.h | 389 +++++++++++++++++++++++++++++++++++
 10 files changed, 443 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/ntfs3.h

-- 
2.51.0

