Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2E51C69D;
	Sat, 26 Oct 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954052; cv=none; b=FPw6ysZ7U87wa1dfTb70yDkzxIP/UxirNto8If/Ly1d6fH/DE2+QBrRljilzcYJJjjkv2Kj22GCZZPSegX2HCqIdK+U8Gh9Euq0X+4GkPIaGWuD42k3xohdYYdTAlYKGa22OHQ8U/97eLc9xMsRFr4WvIeK97vOMPHUhBgX+hEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954052; c=relaxed/simple;
	bh=j+zxkjt/Kb9ZF1jAWfGzqPmaDqTM2RiQ22KLaeHRslQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N+KXSxbSgk/Z418HduIs8zwbcr3yeSJr9VdCWfA6nfQXoVlM9IwiCcPMD2fQsMsih8KibOnWmr+fA6tuEqbdgByq4mlxjE9zAMM7hVrJvNo6MSzlqtwJj0wSit0U6xt1QsFpCKEojmB/a0WgCUKKDKvwPsbZZrlisGMi+6wOlOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=mbxLIxyo; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="mbxLIxyo"
Received: by lichtman.org (Postfix, from userid 1000)
	id 90D25177103; Sat, 26 Oct 2024 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729954044; bh=j+zxkjt/Kb9ZF1jAWfGzqPmaDqTM2RiQ22KLaeHRslQ=;
	h=Date:From:To:Cc:Subject:From;
	b=mbxLIxyoPJjSgjZSh+W916g6DJSQdBE1FmCERgWyFWCx4d0ljEmnc8QCzzGMWXWua
	 px4OPssGIc98PD7NatN5drTQm5+VaHmO7FY9pCuS3svpNNWFKhU1FCvruP6krBokcS
	 P6dmzVLYtAt0GTOIKZ3HopigNTsJ+beXZ/pABzRRgoZmjyzE/iPbtK35OiC+lkwjOO
	 KE7C4Ui1NUaa2lYB+27Wk+GCSABZnGd9q/unCQAYM26Nmmvt/1BnYnfhixy8UhpfJQ
	 dqhb6JbOnA+bqP99/gFAs6AggFdxF+3HfSQ+8w8vLUGMxDBd8yAteF8QWDnph0tApQ
	 j/r66CBCb1fXg==
Date: Sat, 26 Oct 2024 14:47:24 +0000
From: Nir Lichtman <nir@lichtman.org>
To: kgdb-bugreport@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org
Cc: yuran.pereira@hotmail.com, jason.wessel@windriver.com,
	daniel.thompson@linaro.org, dianders@chromium.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 0/2] Replace the use of simple_strtol/ul functions with
 kstrto
Message-ID: <20241026144724.GA892311@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The simple_str* family of functions perform no error checking in
scenarios where the input value overflows the intended output variable.
This results in these function successfully returning even when the
output does not match the input string.

Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
simple_strtoul(), and simple_strtoull() functions explicitly ignore
overflows, which may lead to unexpected results in callers."
Hence, the use of those functions is discouraged.

This patch series replaces uses of the simple_strto* series of function
with the safer  kstrto* alternatives.

  
[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

Yuran Pereira (2):
  kdb: Replace the use of simple_strto with safer kstrto in kdb_main
  trace: kdb: Replace simple_strtoul with kstrtoul in kdb_ftdump
Nir Lichtman (1):
  kdb: Remove fallback interpretation of arbitrary numbers as hex

This patch is originally based upon
https://lore.kernel.org/all/GV1PR10MB65635561FB160078C3744B5FE8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM/

Since the original thread was left with a review and the comments have not been addressed,
decided to continue the minor work left to move this patch forward.

v2:
- Styling fixes
- Fix an invalid conversion to unsigned int instead of signed as it was supposed to be
- Fix one of the conversions to return an error in case of failure, instead of silently falling back to a default value
- Add Douglas's suggestion for removing the hex interpretation fallback
v3: 
- Split to 3 parts instead of 2 (in which the 3rd part now contains the hex interpretation fix)
- Fix the patch series to properly reference the cover
- Fix credit tags

 kernel/debug/kdb/kdb_main.c | 69 +++++++++--------------------------
 kernel/trace/trace_kdb.c    | 15 +++-----
 2 files changed, 23 insertions(+), 61 deletions(-)
--
2.39.2
