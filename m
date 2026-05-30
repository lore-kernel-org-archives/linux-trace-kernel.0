Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A530F927;
	Sat, 30 May 2026 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780152888; cv=none; b=JKJL18gGGCjbqZJEH4/BeF/7iIE0d8NcMtREPoiseNmTmMnVQR20Lkm9goFE1E7eYTOAnIKSr1QwIH08MDOpGnoK5KtoxF2gD3J//iABbs/848ZmuC4UzrdjcZO1cLvESlIi424E9I6odtfKbU3r791feqSdDQTEL6vSiIfIP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780152888; c=relaxed/simple;
	bh=ijsqTA1vGo6ha3UF0JgXWhiGtyuXOjFMwKZAQHQjbok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/v8dOp2Ymfxwgoa7JUKMjZyLp5/gNEsb5hjO33JKfUkrOy6swSJbDEIuPea21hqk7/8BMhjEt0RwgFAmRgE5KEWzVbCO0QhLwBUKeBBcLXSLBl//I6YCjpIOb0mUedqBphef5ENINtZuJYeBf6PyOy/20QA+N4PeTJDOAt/01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id F3B221C05BE;
	Sat, 30 May 2026 14:54:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 44BA41A;
	Sat, 30 May 2026 14:54:39 +0000 (UTC)
Date: Sat, 30 May 2026 10:55:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "chenjun (AM)" <chenjun102@huawei.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] trace: Introduce a new filter_pred "caller"
Message-ID: <20260530105520.640ec340@gandalf.local.home>
In-Reply-To: <b72c8c6ce638449ea9e99e892a25dc86@huawei.com>
References: <20260508122623.74290-1-chenjun102@huawei.com>
	<20260512084750.c17a93d0ccdacddfd52d3d40@kernel.org>
	<20260513124017.770e3098@gandalf.local.home>
	<20260514131901.8c94136f6fede18c608c8a55@kernel.org>
	<20260529103811.37b0e357@fedora>
	<b72c8c6ce638449ea9e99e892a25dc86@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 44BA41A
X-Stat-Signature: d1d5qkei95hyxsogkpie4smr6ntt4tod
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/oxsPtwRyXQZEumPAoDo/zbnd23BhIKnw=
X-HE-Tag: 1780152879-86473
X-HE-Meta: U2FsdGVkX18urbWYFIU7hsVnm1/xHTMSy0C08yNMF6o/VW2OmddRp20lmuXRcr2z9JgvVkc8zfsCUAZOQ25EChoVPbx5lIu4dtsR47fCLeHlPr+3LnCeOzShFUrbu18CdL0nIdRMdVuehOfq6BdGYOUWzE34FVljOU2P+9YkbinzXz7xFP8SrgmI0T7NczuYWTREhq3rppb62c/K1v0YEJXH1Nk3FfQOdUsGL283/R6YCFDpYtFdibxDBGJqo8lD+XdeavmalNh/p7h17CVvcVw+qxmiQqySR1+qZ02up4UAU4DM0qwOC2tSLg03SAaWRYj7myxn6ZlKWy0sQ5gWDvJ1pAFnVuIKlnKYOS7htjnBaXzDgBe0CA==

On Sat, 30 May 2026 10:46:35 +0000
"chenjun (AM)" <chenjun102@huawei.com> wrote:

> > Hi Chen,
> >=20
> > Do you plan on sending updates to address the comments that Masami and
> > I have made?
> >=20
> > -- Steve =20
>=20
> Hi=EF=BC=8C
>=20
> Sorry, I've been busy with other things lately. I'll release the patch=20
> v2 next week.
>=20
> One thing I'd like to confirm is whether to use `called_within` as the=20
> filter name.

I was talking with my wife about this (who isn't technical at all, but
wanted to get her thoughts on terminology) and we came up with simply using
"within".

That is, we want the event to trigger if it is called "within" a function.
Hence, if you use:

  echo 'within=3D=3D"$function_name"' > events/../filter

I think it's pretty obvious to what it means.

Thanks,

-- Steve
