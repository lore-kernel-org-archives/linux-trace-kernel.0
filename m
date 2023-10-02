Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C85C323B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EC7C433C7;
	Mon,  2 Oct 2023 15:08:33 +0000 (UTC)
Date: Mon, 2 Oct 2023 11:09:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Zheng Yejian <zhengyejian1@huawei.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: document buffer_size_kb more precisely
Message-ID: <20231002110935.2fde6637@gandalf.local.home>
In-Reply-To: <efe41cee-42dd-290f-9ec2-ac002e2ec34e@arm.com>
References: <cee6d5cd-e15b-3bb1-f867-de467d96d6b5@arm.com>
	<a1ae1bc0-0677-8284-9f18-1171e1dcb175@huawei.com>
	<efe41cee-42dd-290f-9ec2-ac002e2ec34e@arm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Sep 2023 11:38:14 +0100
Christian Loehle <christian.loehle@arm.com> wrote:

> >> @@ -191,7 +191,7 @@ of ftrace. Here is a list of some of the key files:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A few extra pages may be allocated to a=
ccommodate buffer management
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta-data. If the last page allocated h=
as room for more bytes
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 than requested, the rest of the page wi=
ll be used,
> >> -=C2=A0=C2=A0=C2=A0 making the actual allocation bigger than requested=
 or shown.
> >> +=C2=A0=C2=A0=C2=A0 making the actual allocation bigger than requested=
. =20
> >=20
> > Hi, the actual allocation should still be bigger than shown due to the
> > loss of accuracy when doing unit conversion from bytes to kilobytes (see
> > tracing_entries_read()).
> >  =20
> Right, the sysfs obviously only allows for KB aligned setting, but you're=
 right.
> If set on the cmdline non-KB multiples are possible and accuracy is lost.
> Nevermind then.

I'm assuming this patch can be dropped?

-- Steve
