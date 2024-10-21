Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7B1E0DBF;
	Mon, 21 Oct 2024 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545446; cv=none; b=dXF+Zsss/VcaG/mHpgzlxX9JIjJtFKnoBVz3aX1ejtsgHtPz1Oyaxaln198c8VgMK7EKsVgdgId5emK8rkbew1st9GAeOa2ljqFkjbbt/cZmk/7MtpOg0mgbQnk6MxgauCqTmoddmzdS1Y9Lf075L6bXsrk5ZICWOsnZKST+G5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545446; c=relaxed/simple;
	bh=pv3jKh6fN2c1jXFgbQJcvaSmIksdraQtfExZKZJ0xQg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rtafUKGTk6T+4xwCEBnKCQ+pdEjbuTrx5o+hKPg/MdbrXprLX5LQ9w86oRLxouUXLLTWPgahnCmm84bUj+dHJxKTY95rdHzloL8FKpSL2guAMbFM3ve5e7/d+lsU2icyJw9wrVWQrNfFsTuSl6C23EXc/zgXUzcG0TfCSxOL2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=DqQPc+5i; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="DqQPc+5i"
Received: by lichtman.org (Postfix, from userid 1000)
	id 0A5D417710F; Mon, 21 Oct 2024 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729545444; bh=pv3jKh6fN2c1jXFgbQJcvaSmIksdraQtfExZKZJ0xQg=;
	h=Date:From:To:Cc:Subject:From;
	b=DqQPc+5iwL76k7nifgNBW/2C7LN3NSs/j6dz8GLd/XOA7Il8N4L4PAIXl0BgC8FRt
	 E6ThUou2WHr2qg1dPEMmJc64DCdwDKemhuVZdO1u1IYChppbArGhqf38OqMyTfKa4S
	 BtRl5hVXjd7brJr6qWDnS0xVZyrpQq2dpSDAn2yqIIZ48wZk3TPVZhE2G/lhBz/YU+
	 19gYj34z8OMzG8Rb7AABQXgIczFGVtHFAgG7WL12w4Ss28s+YtPLOdGH4uRcfByJ4u
	 JMOprs0koHPZOmrc+yULjEuBc0SBXeBKoJ5l+GtyLwf0x5x4PUhVDq9wTpTa6jsC0x
	 al8BV/sTyPfSw==
Date: Mon, 21 Oct 2024 21:17:24 +0000
From: Nir Lichtman <nir@lichtman.org>
To: kgdb-bugreport@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org
Cc: yuran.pereira@hotmail.com, jason.wessel@windriver.com,
	daniel.thompson@linaro.org, dianders@chromium.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 2/2] trace: kdb: Replace simple_strtoul with kstrtoul in
 kdb_ftdump
Message-ID: <20241021211724.GC835676@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The function simple_strtoul performs no error checking in scenarios
where the input value overflows the intended output variable.
This results in this function successfully returning, even when the
output does not match the input string (aka the function returns
successfully even when the result is wrong).

Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
simple_strtoul(), and simple_strtoull() functions explicitly ignore
overflows, which may lead to unexpected results in callers."
Hence, the use of those functions is discouraged.

This patch replaces all uses of the simple_strtoul with the safer
alternatives kstrtoint and kstrtol.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 kernel/trace/trace_kdb.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 59857a1ee44c..eadda6e05526 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -96,23 +96,20 @@ static int kdb_ftdump(int argc, const char **argv)
 {
 	int skip_entries = 0;
 	long cpu_file;
-	char *cp;
+	int err;
 	int cnt;
 	int cpu;
 
 	if (argc > 2)
 		return KDB_ARGCOUNT;
 
-	if (argc) {
-		skip_entries = simple_strtol(argv[1], &cp, 0);
-		if (*cp)
-			skip_entries = 0;
-	}
+	if (argc && kstrtoint(argv[1], 0, &skip_entries))
+		return KDB_BADINT;
 
 	if (argc == 2) {
-		cpu_file = simple_strtol(argv[2], &cp, 0);
-		if (*cp || cpu_file >= NR_CPUS || cpu_file < 0 ||
-		    !cpu_online(cpu_file))
+		err = kstrtol(argv[2], 0, &cpu_file);
+		if (err || cpu_file >= NR_CPUS || cpu_file < 0 ||
+			!cpu_online(cpu_file))
 			return KDB_BADINT;
 	} else {
 		cpu_file = RING_BUFFER_ALL_CPUS;
-- 
2.39.2
