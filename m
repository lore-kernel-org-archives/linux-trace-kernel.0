Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C521F18C922;
	Mon, 28 Oct 2024 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143023; cv=none; b=HSCiuYud1WyesqcgbRKFB7qDpnqpOThKBbOom2w66x7szC0MApnH/Kha4EWNNXreO7BUXVBzl72ItyalHLjSioGn4cmtoVbTkg3PK6N14YY2Kq5DDEFA71YTEYLJSyK5zOxnnn94L9cXxNrVUt+HJx6rR/dCPd6R76HykuSBDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143023; c=relaxed/simple;
	bh=y+6RmVA7Vuc+6PEZN2k36qLk2mZfoNZZoCo3OE7qqWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C7dThS/V2XLAOjji80MDAEs+MKoCsjgDhbE+Ob9HHXdf4waLwLVRdgIGQ8LyF3O90l8SaFTJAassFF/dzN5oR9SM3twembPj/s+T/Qe9yfMI34zfcxqFgFC+c5BmAuOJtVxRsNo293zl5KsRM763UEZNzltra7r88rFMB0YQ3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=iY1EWanW; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="iY1EWanW"
Received: by lichtman.org (Postfix, from userid 1000)
	id 9728D177105; Mon, 28 Oct 2024 19:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730143020; bh=y+6RmVA7Vuc+6PEZN2k36qLk2mZfoNZZoCo3OE7qqWg=;
	h=Date:From:To:Cc:Subject:From;
	b=iY1EWanW1N71ET9sPPg78zaRQD0Fwm4YdA7vWsLDwsivNhXtaz1MhUiPOMUiGeglJ
	 JuDqy6lVAyzzlWu6EZWQWuEP1SYEAzxlDD2qvv1I4Nw4i87gKr91HOKNP5Qm7t5dFF
	 KVee8b7bBomGF0j67UhriHI+kUfNmWzTSh4C14cT0z2fV/VZHSVpB3O2PDrgQTGBe3
	 2AzdTXeip/wy7/Pk6cZgwEmIf+Zudw5DmQ0racWGcvGYNCgFzEMXXD+xYih6Se2YG8
	 +rsFtBkql9y5SGxMlP0X+anBrPOIdADK5Jwu25rWlj43+AjExvHNzLb0BjChyNyktm
	 lzrg4kebzRqDA==
Date: Mon, 28 Oct 2024 19:17:00 +0000
From: Nir Lichtman <nir@lichtman.org>
To: kgdb-bugreport@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org
Cc: yuran.pereira@hotmail.com, jason.wessel@windriver.com,
	daniel.thompson@linaro.org, dianders@chromium.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4 0/3] Replace the use of simple_strtol/ul functions with
 kstrto
Message-ID: <20241028191700.GA918263@lichtman.org>
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
v4:
- Fix regression between v2 to v3 in which I accidentaly
reverted an improper unsigned/signed conversion
- Fix nit of spacing in if condition parens split into multiple lines


 kernel/debug/kdb/kdb_main.c | 69 +++++++++--------------------------
 kernel/trace/trace_kdb.c    | 15 +++-----
 2 files changed, 23 insertions(+), 61 deletions(-)
--
2.39.2
