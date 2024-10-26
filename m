Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01170182B4;
	Sat, 26 Oct 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954842; cv=none; b=oWw7whdMqtQw/jya0NfCKVqO7WgLGT1gcy8yVK0d3pM79hN0iZAHDsFxaFZDdy3CowWbeWXV6BDZBoeutH3PAVey+1DRu9mUVZt6pOl5LsbOB8LZAu3O1O4HTnYYo3srl346vStEeO4bb7VQeD2u6khHEU3CBRvf2Ru4wmGwR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954842; c=relaxed/simple;
	bh=1LOBijO8+8t8Q8WP98HjEGTmpGQ9fmPyBouPtW6mbBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWGDPuQtlPLyG4vyvNw2rADgpyzHDUV8jfPR3ukvIeB+U1xniyilmJnbD9PoDEAp0T5W4ZEVGxaMnJTdpK7F1PoazPW/ssKwHVKZOxB3OZsG7LzrvAO0ei22iTX8JgVKN+VxBpSFQu3Zh3DhoXXm7njBDSpbd95tAxp/gT4KBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=FqorxNqV; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="FqorxNqV"
Received: by lichtman.org (Postfix, from userid 1000)
	id 1946F177103; Sat, 26 Oct 2024 15:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729954840; bh=1LOBijO8+8t8Q8WP98HjEGTmpGQ9fmPyBouPtW6mbBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqorxNqVryyCnmkG7CnSzi+K4LAaFz3iVHymQ8XnzFQRDV0KKe+Ri2Pdxelw3JyJu
	 OfcVCmxi7fx/zmjOIlNp8Z8GKWbj7ejhBU8kAM3BZ7nHJq/Yes9hUi2BEeRAh/VVIw
	 DkoMMi4l2baedUUvtuZ11O3tbcc+XxdQz2b07J+Bev4ojAuXkGaxTv0sDcrG1MLSyE
	 kf/3vHla1Gk9Hg1dfaANa4Tm1Hk26iv8wpTemjeKuBWd60xYK2SlEbMfs4MNjx66kI
	 kbmE78YmihAhLLsRTTCub7vUMfmP10mXigt+pyGJV4IHsyVP+evmLEbC2888xl/N46
	 J8lCxn2CIGlKg==
Date: Sat, 26 Oct 2024 15:00:40 +0000
From: Nir Lichtman <nir@lichtman.org>
To: kgdb-bugreport@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org
Cc: yuran.pereira@hotmail.com, jason.wessel@windriver.com,
	daniel.thompson@linaro.org, dianders@chromium.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 3/3] kdb: Remove fallback interpretation of arbitrary
 numbers as hex
Message-ID: <20241026150040.GC892629@lichtman.org>
References: <20241026144724.GA892311@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026144724.GA892311@lichtman.org>

Remove logic that enables a fallback of interpreting numbers supplied in KDB CLI
to be interpreted as hex without explicit "0x" prefix as this can be confusing
for the end users.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Nir Lichtman <nir@lichtman.org>

---
 kernel/debug/kdb/kdb_main.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 930de4fdc708..d929a4335078 100644
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
