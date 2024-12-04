Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29B18C933;
	Wed,  4 Dec 2024 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296492; cv=none; b=ens+XX4OxeFMjhxUR8DNr9LHLvF5MhsnfIGzx/0RvvHvItWI1G8NGHVZDopm/t1xWK03YHurVm01dSXglYqnvyhid6oKzUnV1etr2UanUEdq9xZltyX5N8ttNF7e31Wr2a+Dh63x5OCOhCRrGPLaR3RkxPJpcslXwvdHMFklJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296492; c=relaxed/simple;
	bh=oeN3dOIb3yn5tbkaKmt7PaHQM3+lJCpazwivDl5hcgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIoms1rIX+AEzzMMm/cERG0TY3Q6ZTX8BqgXSbFcJEkg1xnNqsyydUbgftOym4PvHbuIZRvO4991GONS93eEvg32/ISFrhFmd3M0r8uuxtLkDmDW3X+PPV/mXK6GS6fsPp8FhpmhnMPE7DSrVB8DP08ibFucN7cWRMinPn6L62o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=KKVpFWHh; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="KKVpFWHh"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9FDA5E0007;
	Wed,  4 Dec 2024 07:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1733296483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+CoQzNG6j3IQX1IH1EwNYyaraWabx2BrXv+rlkdzLI=;
	b=KKVpFWHhilSqi6Hs7CLzBflV6J56pKDE1GPg5V3UYCwnuGJ6IqtXAn3ccJOOfCCoDkBqdf
	CUipjZPJOP+23GjQTQN3mh74kibZQj74sjLSs+pn21f/ciiSVtI7NJh7m6fUJHMw8vCmDc
	gfHoLjdGkxwXjki2IbXjH9YXZAV+15alQVh43285lY+m73OpXFCnC4ZwLg7M+A0d2C8QiG
	95+1SAW/NETOqdF7XmdB6JZKxqDJjChunH+KSJnuf2C0WB4zLEhVsETmwQVXIldvOSSdc9
	fCb69mGQCYCpezrCJy8XFvXlfeZ//6nDJvcRyc7LZywtVGp0AQ0KFgOrrw/V0w==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Wed, 04 Dec 2024 08:14:39 +0100
Subject: [PATCH v4 1/2] m68k: Enable traceirqs
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-add-m68k-tracing-support-v4-1-e24fe5ef3b6b@yoseli.org>
References: <20241204-add-m68k-tracing-support-v4-0-e24fe5ef3b6b@yoseli.org>
In-Reply-To: <20241204-add-m68k-tracing-support-v4-0-e24fe5ef3b6b@yoseli.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733296481; l=643;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=oeN3dOIb3yn5tbkaKmt7PaHQM3+lJCpazwivDl5hcgw=;
 b=e4Q9SllPlX/hCFnyNNLtAnX2FT6x0/n7apTjHRGG6nUaJ1vlZpafawpG2bgiqVD+kVsAaj2KS
 EKWcOoTj6JYCD1t04F/9828lAzle5Lv7I1K33NB5/Y0E+Eg5sAnQIqs
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

As irq_enter() and irq_exit() already are tracing the state, we can
safely enable TRACE_IRQFLAGS_SUPPORT.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 arch/m68k/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 7c4f7bcc89d76326b9d7280a3bcba79412ead7d2..793ab1e2762609725bbf793f6dffecfa3ecfff0f 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -39,6 +39,7 @@ config M68K
 	select OLD_SIGSUSPEND3
 	select UACCESS_MEMCPY if !MMU
 	select ZONE_DMA
+	select TRACE_IRQFLAGS_SUPPORT
 
 config CPU_BIG_ENDIAN
 	def_bool y

-- 
2.39.5

