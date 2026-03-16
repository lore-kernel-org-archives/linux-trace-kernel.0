Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452238D00A;
	Mon, 16 Mar 2026 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674102; cv=pass; b=G2VLP97dSrsxBH0/iN6aeAdBbOD22PW4GBJt99oL/0w7VrI3jZPLhGpA+Et5tryIRDZr8ZvMcOp/qgIRDg9yo+5XJn18ujTFutifRT0uERIgg+N1B/xtFr2Jvlqc/KNuW+bNZz0NQRv/W/rHSUeZXxUYRwLyqUmu9TmdGQyWlaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674102; c=relaxed/simple;
	bh=1PE7TuS6a3EBeU+KPtkURt1NYuG9WQSofSwD9tG4L3s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ywn5riQxunoRj1d1CR8KJunDgiRU9nGPTln1zdtKIq8ESYPnhiftbq4CCuLQubRflCGlibFsG5iiXDIouO1dWu7Q/HuuS1VgL6/RPP+4LBZ894YF9Aokp2IJhsUgtVulRUrKxoXfU3j5XnF8M9At+0dxH22yyNiJ0JjHr6ca/q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=GdfBad2O; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="GdfBad2O"
ARC-Seal: i=1; a=rsa-sha256; t=1773674092; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=J4eQ/cWQrmHkEPV9BD0Itu+NXMkvb70DaOLXVl1Wv9utGeOBPkN5VaXtpYCHVhZaoeDLx90CppaXGt6zIpapzDbiJnbSjhiifUPm5MkCn/dG0+54zJMreu2DVh8oSM1lMgVQLCsHlREz5nrvPmjZw/Q4VIy0G8zwp0EfD18pU8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773674092; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3X4vo4X445RrifJ2ssVD/zI5YLyKtVANoDTewF/v3iE=; 
	b=IQdh/PnwTkaj5X0PF0P8bQPScPLjeu3ojRpx7lDvV6qsV8izc+gDUCpOkJhFV1oqdYtya3+XsNIC4pitlIy2JQJpZYl2Wwxn+qmBglRJSkd+I5uChHe71bPl+nZ0q+/wfRR8dWVouOnMx42P7oX901cHKgxg0608FJfChgt1cfo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773674092;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=3X4vo4X445RrifJ2ssVD/zI5YLyKtVANoDTewF/v3iE=;
	b=GdfBad2OZvO2mkeIX0t11K0yM1OKZzSSe5Y6d/F60rrvmbjZudoqrMM+X5qBjgL9
	ria/TPbgX27GhLaO2L84zGCyCQMXEjpoJZ4L2tUOQXkc/EV7uMtzL9Oug3YYVyAwHDn
	EE6XSzo74HLnGxqEs3GY9QYdYlN0KNHrweIaUP+Q=
Received: by mx.zoho.eu with SMTPS id 1773674090171538.6075392177464;
	Mon, 16 Mar 2026 16:14:50 +0100 (CET)
Date: Mon, 16 Mar 2026 15:14:48 +0000
From: Josh Law <objecting@objecting.org>
To: Markus Elfring <Markus.Elfring@web.de>, linux-trace-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_17/17=5D_tools/bootconfig=3A_fix_?=
 =?US-ASCII?Q?fd_leak_in_load=5Fxbc=5Ffile=28=29_on_fstat_failure?=
User-Agent: Thunderbird for Android
In-Reply-To: <ecb34439-8695-4562-a9e7-9fac74323adb@web.de>
References: <20260314223425.142966-18-objecting@objecting.org> <ecb34439-8695-4562-a9e7-9fac74323adb@web.de>
Message-ID: <02815935-BE45-4A0E-94EE-435C81681A9D@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 16 March 2026 12:15:08 GMT, Markus Elfring <Markus=2EElfring@web=2Ede> =
wrote:
>> If fstat() fails after open() succeeds, load_xbc_file() returns
>> -errno without closing the file descriptor=2E  Add the missing close()
>> call on the error path=2E
>
>https://elixir=2Ebootlin=2Ecom/linux/v7=2E0-rc3/source/tools/bootconfig/m=
ain=2Ec#L139-L153
>
>How do you think about to use a corresponding goto chain?
>
>
>Would you like to  add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
tree/Documentation/process/submitting-patches=2Erst?h=3Dv7=2E0-rc4#n145
>
>Regards,
>Markus


Hello markus, i submitted a V6 (yes a v6) that responds to all that, and i=
ncludes extra patches to fix some warnings under W123 (maximum GCC warning =
level)

Thanks=2E


V/R


Josh Law
