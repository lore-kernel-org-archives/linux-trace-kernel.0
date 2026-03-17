Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB152FB97B;
	Tue, 17 Mar 2026 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764161; cv=pass; b=bzpG68OQl3gqTud/bn38olwz2j++HFqxijQ2jSJkWIx/QgxONNAr2mnuGTknQQu/50pj0/5hWHYZkqi4y7reg2uWdMJCf0uaS+8fCKnI86D1fUGnHHZRFU2bF/mAqqH8WvghR79x1zXptXAYNWOKAgFz/3+/3UnFzf8y1q20JPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764161; c=relaxed/simple;
	bh=GKOLWVJSQJNfGROgKfb/VcnY/yIntRRjYQzTloYhDWk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=L1oIhMUqnIJHVo9XGrVfn3lm7/0w3RcUT1Y/5ADMTfUqK+ZyA8LRRx6jJEGas7/wwZFyEVEzJ/aSEkh22M/TowmBBkv2XwFN1G/3vvvb6Z+M76EbHDrrnd66XNQhg2ecscm0D8nRnA0pUQ08yYbAZZVSlSQyuwZQVUeWRSW1GIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=AlH5N3kH; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="AlH5N3kH"
ARC-Seal: i=1; a=rsa-sha256; t=1773764150; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=QWSMNnu1J0ZymkQXRyKFvlsPeze1l7AMxKpFIENuBmZN6TQPr9ZSb+yKogXsm2OyyfitmJMXkGWG59/uwRqaXR+C/abbFZ+KgBPnZu08f2ZAnMYgOq+XOraEZGQ1jZH9s8b5tUVZ1fpOsV5qNuyO6GyLRMBg/nC6We5WAB/RBvk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773764150; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=a5k8ajif9yNpgBx0bim+SsIHyvh2dd7dwy2+/b8p0UI=; 
	b=YdTupeGp34U+IVDhDAo6J950Ysdv/mmNv6vKwpQdwkFj+mPvqVlIz3zzT/dUuSmvwEStZ9e/tDL8OoOPsMHwkwzGRAdNAzBssvIZQiCvtV1seUrkgL8/a/n7ZAnJlCUhQkvjFXPq7WYnNovlmRJYEQCcePAYdv4Xif/0D7/7fCQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773764150;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=a5k8ajif9yNpgBx0bim+SsIHyvh2dd7dwy2+/b8p0UI=;
	b=AlH5N3kHqt5TRJmguzd7DjWB7xyu529Dy1JAw9jBXd0k0EemG5I+r2jTYzRCwAjr
	rCVpgQJ9eaDbe4aC9ESdpTeCSpC/0+dcT8WwGsJuqPlvMe8n1h6WCC9h/xFBIiDGAuc
	SQNlsCAbW43fpHl37AQzVcWEgC2Nfi5C1AJzLnvw=
Received: by mx.zoho.eu with SMTPS id 1773764148227188.4992456086418;
	Tue, 17 Mar 2026 17:15:48 +0100 (CET)
Date: Tue, 17 Mar 2026 16:15:47 +0000
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
Message-ID: <C7558275-FE6E-4682-BFC1-903DE8C03C68@objecting.org>
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


Hello Steven! I made a V7 dropping that since masami nitted it anyway, and=
 I was too busy to fix it=2E

V/R


If you would like to review V7, go right ahead!
