Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D84155A52;
	Mon, 28 Oct 2024 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143350; cv=none; b=uOR29OUUC/JcTuPIe3R4NG9VRTTtCpIMnZdr9wQzCEKFF+26hQPQLpgQHFyjkfu0LxTFa0YygvKXYoJRM7v/zn1eP630Sgc4lO022n/Iz6hMF6TIe3w7U9+iV346W/cFFgoVb7g5sBlZRZTgNWkMhbyaRf0y9gwmZj4ChXFtKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143350; c=relaxed/simple;
	bh=szimE7eBz9lG15cvVJZu71amUFqFA7UkiIsHssfIPCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5GoAgmatJd4O0slfa8VLVEj9vm3ArspSPkkX67MARVryUEgjCTyxwYk5aBZAq8zZTtWfOTUE5G4g1Kx38LyaaAjEpBbp+W6UyF/HRC6eOkFCH3ketKi/PF2/ROuY8A95KLcCeu43UG8gw6plQXIsb41oVfdDslTtIRm4QgNIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=R/jywdv4; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="R/jywdv4"
Received: by lichtman.org (Postfix, from userid 1000)
	id 37E6F177105; Mon, 28 Oct 2024 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730143348; bh=szimE7eBz9lG15cvVJZu71amUFqFA7UkiIsHssfIPCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/jywdv42FPkDQrTpWP48OpYogue+g+GhfVCISb5pVNwsXbtvtZ8km20XEiUQegzb
	 O7FznrT4h9ELt/2pv82bOJgTqC6sNB5S5tIeq7px7bbj3mhksZpBrq3SazNfHqDRWJ
	 Yx+JNEheHm1C10scgOBjLi/UZP0sXA7C9gZsOF7pX2HphD87aQaBm3mMEE/kHFxXbR
	 fnksx5Ro5eF++OqzgHIHZucx45OJ/ph5NYa9G25w5i/8J3/UAh5vrAojgrFzun88l6
	 gJXLK6Mxa3UwDhSkTzgKrSF3Cf9uOGXgeazHMT62aYp3OJYCl24R1T0Tjd3wjHHI9O
	 u1EZAuMHzerSg==
Date: Mon, 28 Oct 2024 19:22:28 +0000
From: Nir Lichtman <nir@lichtman.org>
To: kgdb-bugreport@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org
Cc: yuran.pereira@hotmail.com, jason.wessel@windriver.com,
	daniel.thompson@linaro.org, dianders@chromium.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4 3/3] kdb: Remove fallback interpretation of arbitrary
 numbers as hex
Message-ID: <20241028192228.GC918454@lichtman.org>
References: <20241028191700.GA918263@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028191700.GA918263@lichtman.org>

Remove logic that enables a fallback of interpreting numbers supplied in KDB CLI
to be interpreted as hex without explicit "0x" prefix as this can be confusing
for the end users.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 kernel/debug/kdb/kdb_main.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index f8703ab760d9..5f4be507d79f 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -402,23 +402,15 @@ static void kdb_printenv(void)
  */
 int kdbgetularg(const char *arg, unsigned long *value)
 {
-	/*
-	 * If the first fails, also try base 16, for us
-	 * folks too lazy to type the leading 0x...
-	 */
-	if (kstrtoul(arg, 0, value)) {
-		if (kstrtoul(arg, 16, value))
-			return KDB_BADINT;
-	}
+	if (kstrtoul(arg, 0, value))
+		return KDB_BADINT;
 	return 0;
 }
 
 int kdbgetu64arg(const char *arg, u64 *value)
 {
-	if (kstrtou64(arg, 0, value)) {
-		if (kstrtou64(arg, 16, value))
-			return KDB_BADINT;
-	}
+	if (kstrtou64(arg, 0, value))
+		return KDB_BADINT;
 	return 0;
 }
 
-- 
2.39.2
