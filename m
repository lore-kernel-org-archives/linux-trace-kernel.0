Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138171F942;
	Sat, 26 Oct 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954606; cv=none; b=iYBqMb7wKA4wtNzSv5UBEJ4a9fgFdiYuArMc5h4p2fBTI63mLCKFrnZI5T54hHHRESZ4Fus/DLTTYOebss35kUwamE6X5Qe3+9V0+PwkCmSWEInsEQIITRC5dqye6a+2jUG9A1zJG0KbPerNVAe/gfMFQfnW8PCZYK3/GQX083Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954606; c=relaxed/simple;
	bh=dm93p2HTGECj1+ovJm8bfabWgFNTsuuWOau2Y+LDgXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWzz8hAUmtTaL7TUOdkQK1ZMCnV0FML+aKjF9ZpM8WIeB0ZjRTTdCUNVQZ1Kw/drokJ8aJ49PBpIWKUV/ta9FzUcPO+Nqs2KRSa4OUbq5XYrPIucJwZQ9rjqVLVY6YsfqOWhCiGVTyF15V6SAuwa1eFQaVWbDK8Wd2dV3xpCY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=R0zWWKbp; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="R0zWWKbp"
Received: by lichtman.org (Postfix, from userid 1000)
	id 25DC2177103; Sat, 26 Oct 2024 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729954604; bh=dm93p2HTGECj1+ovJm8bfabWgFNTsuuWOau2Y+LDgXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0zWWKbpQy+LIbfgNXjAlEcfcilL2OV01zfjc46Pdeh/W1/ohNexyZtA7KH6mr8iP
	 i+imQmDCbRSe/W9kF1zfb2+pjLLopjQSrVSFCj1erKDvcbsUx7mBGkIYaVKU0vkzeH
	 SaMLYzxGn781k3a3TZ9Mi7NKRkAFu5Z6mL5Pw1skbyOdvfJse2hMclvhRN3sMoGGxQ
	 eF5b4ajVlOO+f9slBYaSZirB1wYt663VGQ8D9U1eS/IxwBJg17Sof46U0rOYoEB3o8
	 dPkLUWrHYF7rsdA/lFCIFpopnaTEtqjtf0GF6El3hKEHT8n2lyT/cEVqRg6dnnBc9j
	 5oNQ0yN608L3g==
Date: Sat, 26 Oct 2024 14:56:44 +0000
From: Nir Lichtman <nir@lichtman.org>
To: kgdb-bugreport@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org
Cc: yuran.pereira@hotmail.com, jason.wessel@windriver.com,
	daniel.thompson@linaro.org, dianders@chromium.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 2/3] trace: kdb: Replace simple_strtoul with kstrtoul in
 kdb_ftdump
Message-ID: <20241026145644.GB892629@lichtman.org>
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

From: Yuran Pereira <yuran.pereira@hotmail.com>

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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[nir: style fixes]
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

