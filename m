Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C01A9B46;
	Tue, 25 Feb 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507616; cv=none; b=DuqDnd3ycbN9lrhsrpXDw548Xnj/U3Ua0XgoZVBmsKfGjdF48xAadGIz2Tirt0mBzs/9NWQESXBsjd7Te6GaRPcoNan6ZMlT0+TNwVTkDUK+nxdE4kRAw1sk2Fqplo02KYaG97QeqOdGUuSnxS12Cc6uLsqa6UPgohWxVh5ZzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507616; c=relaxed/simple;
	bh=K/F1CY7g3Rg1wpx3W23+5xHOx/IOS3QKZnW8nZXMLXE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pRAItC2amRNkhM5OpEk+8QQwoYWRaN5yjL4Mq0DHgaJTwT/voWH+mzm5tDwNVdNlGV1L1+qRG2KUOqSBV2Ncys6f8Jja4nGz1ieXzddWLdEamQchbDdAOdYLj9c2AQjKUgwcvdlrn4iodBZYFqUKQzU97+ULkPtGGPPk+wLR9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFD2C4CEF1;
	Tue, 25 Feb 2025 18:20:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tmzY6-000000095Yu-3KXv;
	Tue, 25 Feb 2025 13:20:54 -0500
Message-ID: <20250225182054.648398403@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Feb 2025 13:20:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/4] scripts/sorttable: Use normal sort if theres no relocs in the mcount
 section
References: <20250225182004.473875894@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When ARM 64 is compiled with gcc, the mcount_loc section will be filled
with zeros and the addresses will be located in the Elf_Rela sections. To
sort the mcount_loc section, the addresses from the Elf_Rela need to be
placed into an array and that is sorted.

But when ARM 64 is compiled with clang, it does it the same way as other
architectures and leaves the addresses as is in the mcount_loc section.

To handle both cases, ARM 64 will first try to sort the Elf_Rela section,
and if it doesn't find any functions, it will then fall back to the
sorting of the addresses in the mcount_loc section itself.

Fixes: b3d09d06e052 ("arm64: scripts/sorttable: Implement sorting mcount_loc at boot for arm64")
Reported-by: "Arnd Bergmann" <arnd@arndb.de>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/893cd8f1-8585-4d25-bf0f-4197bf872465@app.fastmail.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 23c7e0e6c024..07ad8116bc8d 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -827,9 +827,14 @@ static void *sort_mcount_loc(void *arg)
 		pthread_exit(m_err);
 	}
 
-	if (sort_reloc)
+	if (sort_reloc) {
 		count = fill_relocs(vals, size, ehdr, emloc->start_mcount_loc);
-	else
+		/* gcc may use relocs to save the addresses, but clang does not. */
+		if (!count) {
+			count = fill_addrs(vals, size, start_loc);
+			sort_reloc = 0;
+		}
+	} else
 		count = fill_addrs(vals, size, start_loc);
 
 	if (count < 0) {
-- 
2.47.2


