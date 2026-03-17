Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D09391518;
	Tue, 17 Mar 2026 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732873; cv=pass; b=k1yOISMz0IeG1hqbHqgXzA540Dd7hC13dty25j+9r2qxdB5tIp9NnlQf84S1NFwq/pf6XiNQgcxd430jrGNaDKVSUkS33uzS+zN9rbD+2sbkpku5QzbPSX88C7wNvQA0Zk1gHUBeR0OTQ+3CKnF61IrpDkrhEwAk1/Un2uel9E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732873; c=relaxed/simple;
	bh=vKg77fp7EjQ5/vXw7HIME5OpqJ13OZZGAngHiawOHI4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BIuleF2A9zinvM6bG5zBFoeMP5WmkbPLVcz0OoGtYl/FCLnVfr3+Fmr7O7jErlb4HqoMnK6mmNwNwfh8EQfpaUv2eu2SCxShoyglUqGhiIDSQmpd2bQBa3A+Z00AvFHHwBr2CLgKnP0Y0FBwHns4yWL73qDYyhG8XRPGpnYYd8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=if6qUHeo; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="if6qUHeo"
ARC-Seal: i=1; a=rsa-sha256; t=1773732862; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=GB/+sZePmh8S328+yue+OLDhLApENjU0F0QxordB0o406N7hwBnBMuwpnehvB7BI7VvCU7dkxwi90y/wVGz1hoiFZecRfi51X1PfISx5+W9LQ6xWuASOZPsOBrXi5QyIb43dAaASp1SXNigmzlMIemaDxPFqgVNckMsnpKveTvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773732862; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WbneL8mMF7Kqg4IIqb8oheS1RHuj3gN2RquuoBUiFoU=; 
	b=L16d+H9DT29eRp6g+m+KexxfMLUaSiJMcKaR1lszgjVp/sv5uux0gMD/kTqtEY4wBdtPPcTJImg1jW1MKOUan8GE63XVIQSkf65JYCu87fNfL5xPOnjFZ4233GAibbglpOgIZPu26b91kHIxCbrLn2QVNR7Kb+ScGEIlaDLyE0s=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773732862;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=WbneL8mMF7Kqg4IIqb8oheS1RHuj3gN2RquuoBUiFoU=;
	b=if6qUHeo55SGnoD8Nn1gScGanYAvOwA/BAfb+9Deb9rapJ0txHP5RjMDPKsR+S3l
	H/Pcm62J2Po0vslYWlTjZ53XGE//5+lAvttNWguBEJEkQevcBzHjmcceBg+gbJE9NAT
	lu8nVQ1wahvKNPiJWAlzdOSSFdvlwzCuWk+ZjxYk=
Received: by mx.zoho.eu with SMTPS id 1773732859514152.36525702964366;
	Tue, 17 Mar 2026 08:34:19 +0100 (CET)
Date: Tue, 17 Mar 2026 07:34:20 +0000
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_11/17=5D_tools/bootconfig=3A_fix_?=
 =?US-ASCII?Q?fd_leak_in_load=5Fxbc=5Ffile=28=29_on_fstat_failure?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260317163151.264b0617484d202daba85f0f@kernel.org>
References: <20260315122015.55965-1-objecting@objecting.org> <20260315122015.55965-12-objecting@objecting.org> <20260317163151.264b0617484d202daba85f0f@kernel.org>
Message-ID: <11AC8826-E8F6-431F-90DC-19AFF6C45138@objecting.org>
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



On 17 March 2026 07:31:51 GMT, Masami Hiramatsu <mhiramat@kernel=2Eorg> wr=
ote:
>On Sun, 15 Mar 2026 12:20:09 +0000
>Josh Law <objecting@objecting=2Eorg> wrote:
>
>> If fstat() fails after open() succeeds, load_xbc_file() returns
>> -errno without closing the file descriptor=2E  Add the missing close()
>> call on the error path=2E
>>=20
>> Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
>> Signed-off-by: Josh Law <objecting@objecting=2Eorg>
>> ---
>>  tools/bootconfig/main=2Ec | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/bootconfig/main=2Ec b/tools/bootconfig/main=2Ec
>> index 55d59ed507d5=2E=2E8078fee0b75b 100644
>> --- a/tools/bootconfig/main=2Ec
>> +++ b/tools/bootconfig/main=2Ec
>> @@ -162,8 +162,10 @@ static int load_xbc_file(const char *path, char **=
buf)
>>  	if (fd < 0)
>>  		return -errno;
>>  	ret =3D fstat(fd, &stat);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>> +		close(fd);
>>  		return -errno;
>
>Sashiko=2Edev[1] found that close() will overwrite errno=2E So please mak=
e it
>
>	ret =3D -errno;
>	close(fd);
>	return ret;
>
>[1] https://sashiko=2Edev/#/patchset/20260315122015=2E55965-1-objecting%4=
0objecting=2Eorg
>
>Thanks,
>
>> +	}
>> =20
>>  	ret =3D load_xbc_fd(fd, buf, stat=2Est_size);
>> =20
>> --=20
>> 2=2E34=2E1
>>=20
>
>


I'm on the computer now, I'm cleaning everything up as requested, expect a=
 patch coming=2E

V/R

Josh Law
