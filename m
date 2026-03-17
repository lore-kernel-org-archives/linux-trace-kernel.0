Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB82E36EAB9;
	Tue, 17 Mar 2026 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768954; cv=pass; b=ng0Q30Tm3xHxlje5r6vJKCletjZzzUkT+Bwba5ynAhPCsL5VCvvGZ/h7T02K/IlLksRiPvnt0eyJt/l1ShSClefjG9gDZS5N47448ZoUG1k4hBun5LhYX3uDJYSkLvKb0i5uCJ24uwHLM9Z/FAghY1pq0UkdtQrFEiYg+c13hSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768954; c=relaxed/simple;
	bh=mqMivRCdra1WMpVA1OWjXG85kKrY0EuPOfuZjgZBfuQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fIY8HodpNeW0rSDS2vodtt3dvM8dSD9/aofrQBcxnK1+6j37r8btkcnCqoZKnJ6Zp96updYRIko5lAtDmRhaS4nS3T12sis6V7YiMeGCG3cBSQ+niTwD36zHI08ANttUdpe5PuylJC7U1+Fkqy+UxHVeJcilEmrqIW8zFDxS80s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=YQYAkvWq; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="YQYAkvWq"
ARC-Seal: i=1; a=rsa-sha256; t=1773768940; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=BFZO5ondVGzJjynuLD3aODRseRy3Tny9o/Q8xJC8+G85r1CXgtFVCvTnM6odn5/UMQBYRlY4iOqFb+Vzt9CnxOYcsFMcnpLgyGbiGBdSkJbldGqQ2AAGArZrhjC844bF8TDeiWgIzzEI3OGpOxGJx219ANPmO6Mn3nHn11LojjQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773768940; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xpqeAix+M+JLQ7SACoXaqtH9U6HHeAdc3zVVlBD/804=; 
	b=hITJlslowpHXk68R5z0lFeeNu75wQ48Uo7crbTC372YEiz5ZFHOhUm5N1Fb8gEpXbQ+B+1EaScyR3woELbG5Qs6S8qcOhjCimtX2775Yw9lnLLBgnsRahQ2NC6RDagUnJIf4kQvlayRDIHL8MipmKlIttt6UFuAlEWeaTTpij7A=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773768940;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=xpqeAix+M+JLQ7SACoXaqtH9U6HHeAdc3zVVlBD/804=;
	b=YQYAkvWqHfRrvasgQUlURm09SpvX5pUD3Fc7K50prxDFncI99NhwKKdNvgRQITVT
	3bCeW4BeemweRKv2IzOn/V0H9UWSFmdbzX6VCyWFuNqH2vDKl1FORl+r9HrNML98yLZ
	15kqL1nQYd8QcwVNnlIVqjYV8PmE5hTaO94szkXs=
Received: by mx.zoho.eu with SMTPS id 1773768937967440.42089534876914;
	Tue, 17 Mar 2026 18:35:37 +0100 (CET)
Date: Tue, 17 Mar 2026 17:35:37 +0000
From: Josh Law <objecting@objecting.org>
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_16/17=5D_lib/bootconfig=3A_fix_s?=
 =?US-ASCII?Q?ign-compare_in_xbc=5Fnode=5Fcompose=5Fkey=5Fafter=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260317121507.30735331@gandalf.local.home>
References: <20260315122015.55965-1-objecting@objecting.org> <20260315122015.55965-17-objecting@objecting.org> <20260317165549.99ea4171d7672f83ec3b6fc4@kernel.org> <20260317121507.30735331@gandalf.local.home>
Message-ID: <6C24C50A-810F-4A42-A638-19D1288374E2@objecting.org>
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



On 17 March 2026 16:15:07 GMT, Steven Rostedt <rostedt@goodmis=2Eorg> wrot=
e:
>On Tue, 17 Mar 2026 16:55:49 +0900
>Masami Hiramatsu (Google) <mhiramat@kernel=2Eorg> wrote:
>
>> > --- a/lib/bootconfig=2Ec
>> > +++ b/lib/bootconfig=2Ec
>> > @@ -319,10 +319,10 @@ int __init xbc_node_compose_key_after(struct xb=
c_node *root,
>> >  			       depth ? "=2E" : "");
>> >  		if (ret < 0)
>> >  			return ret;
>> > -		if (ret >=3D size) {
>> > +		if (ret >=3D (int)size) { =20
>>=20
>> nit:
>>=20
>> 	if ((size_t)ret >=3D size) {
>>=20
>> because sizeof(size_t) > sizeof(int)=2E
>
>I don't think we need to worry about this=2E But this does bring up an is=
sue=2E
>ret comes from:
>
>		ret =3D snprintf(buf, size, "%s%s", xbc_node_get_data(node),
>			       depth ? "=2E" : "");
>
>Where size is of type size_t
>
>snprintf() takes size_t but returns int=2E
>
>snprintf() calls vsnprintf() which has:
>
>	size_t len, pos;
>
>Where pos is incremented based on fmt, and vsnprintf() returns:
>
>	return pos;
>
>Which can overflow=2E
>
>Now, honestly, we should never have a 2Gig string as that would likely
>cause other horrible things=2E Does size really need to be size_t?
>
>Perhaps we should have:
>
>	if (WARN_ON_ONCE(size > MAX_INT))
>		return -EINVAL;
>
>?
>
>-- Steve



I'm making a separate patch based on this=2E

V/R

Josh Law
