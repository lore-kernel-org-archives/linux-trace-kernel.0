Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F7835AC2F;
	Tue, 17 Mar 2026 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789505; cv=pass; b=FJ9qOgGICSVfD14PsfaO5pIAJ/oCkWXLS5RnkUGdlFOjLeZjYQY/ZOkQjkHAVUY8rnM0YxzSesYB4pDwomeDHXXolrZwGRSN1Ec7w6/pCoM+6TzvxNMo5tIb1t0YVcFr6Jz4lBx9AlrbI5t90bmPE6eCSrmWTAK3o310pglMkD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789505; c=relaxed/simple;
	bh=EVWNA+Zior6ZBsOKMwwI4GMg1XS0OMBOOeJPh8uzPqY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=f+tGHjKyO6Vy+v0bm/GNa67VWRM1e0wMUuKgluRRk9WAroJYwAZSjcvAqAc8tsrlexcJac+2s8u0X8FcEQ8rSL8WgPMTS/mqbH+lfQgvZg/ZpO4DIq6gXdGHadWOJUZ/mv27c7ch9Rw7UWjKUAxc1JOzn8ciiZu2z9HpA9NwqKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=cta/W28V; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="cta/W28V"
ARC-Seal: i=1; a=rsa-sha256; t=1773789494; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=A2v/5dxNbeegj0A3w+K8NiEf9TE84MDnet8r4c+0PyoHpPHVaTIHNSf3ltrApJ0gxlMYwCv+9hHUy2UVxTCqqg15gteN8UGcp++xlq8YdZV3txuaKOrrQW70tJlJfhtqKvENcqXXRnHWX9tnNV9Uw+lfpBgw6vpGXJaIYKb3J/I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773789494; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A/vNRUuI1kegb5CTCOELb+kcO6Up67ak0QJbpV3EAAE=; 
	b=iPNBxUCm66KJ+GlsQgLWWxObrLCVS5u6pRg8odgIECCwZ4ugYsC/gR8dpjVvJv1p0zcW9t2mb4o/BElVODHacFtTFkfips/6uVhaKhBxNUxo9eaPmtmGoB9WxpvLIFPGIQUAPg5sM/7OswEnH/zZP/TmwnZVjwOmTaeLw5HB+k4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773789494;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=A/vNRUuI1kegb5CTCOELb+kcO6Up67ak0QJbpV3EAAE=;
	b=cta/W28VXfiyi+vIL5/Nniij/3uUhjWrFTkARxMGkyRTptgDgMLsMIhNFb2WUtLQ
	fjrtzT4392DZNd/MkoJTyEvpe6F3HP5q1lCtNSeXrZTPH8cB4B59aBgxjsGtfhyy8Sd
	gkLxLqqXfmtXBygWlBkQGQbCb7TE/aU8Jx8g8LQw=
Received: by mx.zoho.eu with SMTPS id 1773789492364821.3518028199961;
	Wed, 18 Mar 2026 00:18:12 +0100 (CET)
Date: Tue, 17 Mar 2026 23:18:11 +0000
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
CC: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_16/17=5D_lib/bootconfig=3A_fix_s?=
 =?US-ASCII?Q?ign-compare_in_xbc=5Fnode=5Fcompose=5Fkey=5Fafter=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260318081540.44c164f2c67d80acf14eaf2e@kernel.org>
References: <20260315122015.55965-1-objecting@objecting.org> <20260315122015.55965-17-objecting@objecting.org> <20260317165549.99ea4171d7672f83ec3b6fc4@kernel.org> <20260317121507.30735331@gandalf.local.home> <20260318081540.44c164f2c67d80acf14eaf2e@kernel.org>
Message-ID: <DA935449-83A1-493A-BE8F-40393FC22422@objecting.org>
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



On 17 March 2026 23:15:40 GMT, Masami Hiramatsu <mhiramat@kernel=2Eorg> wr=
ote:
>On Tue, 17 Mar 2026 12:15:07 -0400
>Steven Rostedt <rostedt@goodmis=2Eorg> wrote:
>
>> On Tue, 17 Mar 2026 16:55:49 +0900
>> Masami Hiramatsu (Google) <mhiramat@kernel=2Eorg> wrote:
>>=20
>> > > --- a/lib/bootconfig=2Ec
>> > > +++ b/lib/bootconfig=2Ec
>> > > @@ -319,10 +319,10 @@ int __init xbc_node_compose_key_after(struct =
xbc_node *root,
>> > >  			       depth ? "=2E" : "");
>> > >  		if (ret < 0)
>> > >  			return ret;
>> > > -		if (ret >=3D size) {
>> > > +		if (ret >=3D (int)size) { =20
>> >=20
>> > nit:
>> >=20
>> > 	if ((size_t)ret >=3D size) {
>> >=20
>> > because sizeof(size_t) > sizeof(int)=2E
>>=20
>> I don't think we need to worry about this=2E But this does bring up an =
issue=2E
>> ret comes from:
>>=20
>> 		ret =3D snprintf(buf, size, "%s%s", xbc_node_get_data(node),
>> 			       depth ? "=2E" : "");
>>=20
>> Where size is of type size_t
>>=20
>> snprintf() takes size_t but returns int=2E
>>=20
>> snprintf() calls vsnprintf() which has:
>>=20
>> 	size_t len, pos;
>>=20
>> Where pos is incremented based on fmt, and vsnprintf() returns:
>>=20
>> 	return pos;
>>=20
>> Which can overflow=2E
>
>I think that is vsnprintf() (maybe POSIX) design issue=2E
>I believe we're simply using the size_t to represent size of memory
>out of convention=2E
>
>>=20
>> Now, honestly, we should never have a 2Gig string as that would likely
>> cause other horrible things=2E Does size really need to be size_t?
>
>Even if so, it should be done in vsnprintf() instead of this=2E
>This function just believes that the caller gives collect size
>and enough amount of memory=2E Or, we need to check "INT_MAX > size"
>in everywhere=2E
>
>>=20
>> Perhaps we should have:
>>=20
>> 	if (WARN_ON_ONCE(size > MAX_INT))
>> 		return -EINVAL;
>
>I think this is an over engineering effort especially in
>caller side=2E This overflow should be checked in vsnprintf() and
>should return -EINVAL=2E (and the caller checks the return value=2E)
>
>Thank you,
>
>>=20
>> ?
>>=20
>> -- Steve
>>=20
>
>


I submitted V7 dropping all them patches anyway, V7 should be perfect now=
=2E


V/R


Josh Law
