Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC5D2609D0;
	Fri, 28 Nov 2025 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764295203; cv=none; b=dU4dcixgmFkvTePLric5UKVckwqtf3YjhRkIbfIsY1TpeCy+d6YZ1/Ab3SWEyo2djPa323vsKMCxe8oEqp7SyOIlomwfwy7WEDyRVwb/AVP4Rz/pHOCiLRiXpvrkXk/gRfabTdQ27Mukll8G3sykjG0HJswakaIU7XWQ/UfkEO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764295203; c=relaxed/simple;
	bh=aX9+hkSdCiZ4G5yz81EIzz8MyiWs6MZTl+C8rieqgYw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=T0XJfdBi5dtq5LJz9YbicQstXK+Dw2Ll3QKsGABXnvPzhF+UqY28dTUcoDRl+pKUw2doQ0v3WnxSL1zUc9EsitCuZYJ8zb/J6rc/QhMQ4cKOU/+mlvCXPeVVDoVK9ylThsUfWeab6h1nOeJrf1G0A0y+HqGbi7WqWcotg5tOoaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIO5lpa+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIO5lpa+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A5BC4CEF8;
	Fri, 28 Nov 2025 02:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764295203;
	bh=aX9+hkSdCiZ4G5yz81EIzz8MyiWs6MZTl+C8rieqgYw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=VIO5lpa+oLOHCjQzAE0J88sNpqYLKLIIbI2kJ5I5t+N5Tja3E74lMoQtzt11QyrR6
	 SGZWDrwq30ENGXMIf3RKfLqMLShVyy8N3IWZLKReeFQrlEVUQprB9W6BYWEUvx7ZCQ
	 cljeqRcgor8Sij9K98ZecLbBy2/FC9GXr9anP76n97Xsg7tG2AQ4mqnQqpo6izBFD+
	 lijtYwRY9q6xeMwrPimBoUE0r0J8SayyqdaoWgKhMIf3VoU5cqrEpWydbuFmqPL36i
	 nunsIjLv+Pka6AAPH69HHWjt27DnHPRJRjcHlUufJL+fMqZVgbO2UvVtyzLoXPq4sW
	 OrIc3HxQ1SJbQ==
Date: Thu, 27 Nov 2025 18:00:01 -0800
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_overflow=3A_Introduce_str?=
 =?US-ASCII?Q?uct=5Foffset=28=29_to_get_offset_of_member?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251127204342.05fc985e@robin>
References: <20251126145249.05b1770a@gandalf.local.home> <202511262356.6FE5084CB0@keescook> <20251127204342.05fc985e@robin>
Message-ID: <6219BF5A-0EC3-4111-A329-D35244C9714A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 27, 2025 5:43:42 PM PST, Steven Rostedt <rostedt@goodmis=2Eorg=
> wrote:
>On Wed, 26 Nov 2025 23:58:01 -0800
>Kees Cook <kees@kernel=2Eorg> wrote:
>
>> > +/**
>> > + * struct_offset() - Calculate the offset of a member within a struc=
t
>> > + * @p: Pointer to the struct
>> > + * @member: Name of the member to get the offset of
>> > + *
>> > + * Calculates the offset of a particular @member of the structure po=
inted
>> > + * to by @p=2E
>> > + *
>> > + * Return: number of bytes to the location of @member=2E
>> > + */
>> > +#define struct_offset(p, member) (offsetof(typeof(*(p)), member)) =
=20
>>=20
>> I wonder if the kerndoc for this and offsetof() should reference each
>> other? "For a type instead of a pointer, use offsetof()" etc=2E=2E=2E
>
>I know I pushed this to my for-next branch already, but it's the top
>patch=2E Looking at my code, I actually have a lot of places that use the
>offsetof() for a structure variable and not a pointer to a structure=2E
>
>Thus, I wonder if it is better to have this as:
>
>#define struct_offset(s, member) (offsetof(typeof(s), member))

I'd rather it keep the same API style as struct_size() if it's going to sh=
are the naming style=2E

If you have an instance and not a pointer, just slap on a & :)


--=20
Kees Cook
