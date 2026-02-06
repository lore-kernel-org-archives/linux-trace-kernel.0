Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680E336EF7
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Feb 2026 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770350687; cv=pass; b=U2pH5tAExo0f23poIleqePuCY184eCgQhHPoxV9+4L4rk3qmkY/tGlIrai299G0bnWi2gXJmn5NISh/bP0kG8RHcsOZOAEyVmUC6MS0REzmZ4PuHa8ZXvbxmiXKbxou4wCJrRs9vGI9RMgNFXobzhFq/AUm5DOG/kP9WEyxGEkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770350687; c=relaxed/simple;
	bh=V/aJ/GCLGLGPoizSevf2y3N2Tk+DqVaDobtM/WbvdIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQDrFkeeJotOkX72dluicQwy2W70UWLEg45zeKNF8kfuJxZEuqiasNNOhpa/H4egPWR8jHYw1N3YGkyjaxFMDcDYQ42QfHmmnqzyFLlb6gOh78hsHvAlFvkhb6tCnVsXOvet6b/h/3RHsS10ehQmK4tpt3wFoJV5LTpdNPFkOdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZKl1kHA; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZKl1kHA"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8850aa5b56so292214066b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 20:04:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770350686; cv=none;
        d=google.com; s=arc-20240605;
        b=V+70g9jBR5yo2VgJE02j789eXPjBNSpWZqORRnMykJu6E59IqjcdvGQUsCDtTE4Ho9
         G5cgJYl4qtkU7UNABpnemI4NRSZFwtWf8bihaaaNTXjKRItBCJu8vQV+R+yAqR8ly2Ky
         DQrHd24hX/9tku0K9Bq2L+tVYk7nZmJEwVGg27XEwVmwAcoZt0mGJ9FwEiVbOptzGl4s
         2WjUB/D7F8BiUBbZaj+t116z8ZS8IDWwFRYKFqcTDKbAECuECITj2OpKyjM06yItTfpJ
         TB1EVRtqLSyyyxDWLkSTAn6+ld0GbI8M00Q1lH2cJZzL7wDBN166dbewiY/9T9D+nq/8
         sghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qDmoqxUM6FuQfJT/S+oJtji47+ywL+GFm9heiw+ZAPE=;
        fh=fe5z4AesPz/WAeHLc5GoBsGerLLSTIuwDJ1V85UlKKw=;
        b=Wz9JJRo+MOSEmB+NmfJR2TvkkExLe5CZ679ild3v8Y2yIVatcz6CadozdeYvYiUSFa
         Ek95LUcFYAF5JU4/s/yZeA1g5yP3x9DcrBbFTcbLQar46yT42bqib4wYkAK1dsTQzNUG
         uz/gxT/lONJbwvWHl+Ak3oahdArPkfb5ubbU3iOjoBPVvuY37wn6a4DbXIzui2D+BmUy
         yz57i7u6n7nHGDJd4z7PjtuT0e38G5SEr2gLISb4iI9HxbSBDfFsTNgJx5qwfON0G5iN
         nzogXTniWuxq6ZTvpSXoi8eho5iZ0Wn9wDwim//P99npckeW17K1iitwdMi88RFZiBMu
         rrRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770350686; x=1770955486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDmoqxUM6FuQfJT/S+oJtji47+ywL+GFm9heiw+ZAPE=;
        b=CZKl1kHAq1wpn6gJ+BvbIhJ673VD4dqP7kVroZ/sC4F/9UD3j+cAAMD1zWr+S8G6o1
         maT7UCC/DRBEeRLOhr/xsaI0KQKlGQ21SbaPht5YmcfBbijM/ugIZpAqroJ8WyYwM4Q1
         0IIgZ49paYAzNebfpTm7JsFrV8kYIiuZyInZX9ULOm8xmoY8q/wOa/5rfGvVA3oPoTti
         8bhQOwfVo/J45cetQGTK3HoJke712uQ01VowJv8KV5sV8IE4rf1tNNhFRXSLWTlhNPCA
         Aswa3+tOz//Npx/LQwtyiY4JQPc1cja9PV78bUpzH3HU8IWWCq8fn4dKdlPmL6171XPR
         2nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770350686; x=1770955486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qDmoqxUM6FuQfJT/S+oJtji47+ywL+GFm9heiw+ZAPE=;
        b=gtuW4JjScIXu7u8t3ysUbdhy4hNiF3g9gIaYTyz49vxsnp2YRbF77U0yCZjiELN/dR
         0KDb4Q+FIHNmKygCSwOeaEe2KM2RX+Z5UYtvE40wRSWqbKW5EYphlU4nhfvHwMSSmQGc
         Uy4fzkfVhs2ZI+dfJ4mwZ4JsPM5ytQyBeSfTFzcQN6t9OjBVc2cPa73euA6oNbQmixw6
         B0nlkFMVYuWeJyfkIgvDti8L93QXrYfp62jzStG3wpPRbBsBLYtrVixj/MDOlbr3u5a7
         QGiz+ZH3LaaNyKqjOvVnZ1TIEyhnkjVsqYDkLo5kX4q22DtKOa+dZW0fi4Bqk/3nZySv
         cX3A==
X-Forwarded-Encrypted: i=1; AJvYcCW8ypA2qkA9gNkgB3Cz8Q93+yGw2+5macOqbiqAGUM2ZzYMIm5GaAWfaKXg56Mo6ip8H9kyXYXx+YUaGCkztiSwQu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyT8+N9g+P80wCPw+p906XXKS4f2As1ywMpJqOSPCFd0eRW8Df
	o0dLuH1WfvFGxv0fRRI7SNcU+WHGK3CYZKeBTZgtGX6mHcj1JGg613DluvhLQ8WK6O1vCy0T/uF
	XWX9eu4t+jkDUYO3n3Naj6mnl227BV9o=
X-Gm-Gg: AZuq6aK5Y2h8Cp58D+jBdxk2zYUdoJuDMwvQLgESYokYw60UIHLZXNv8ImSeypZ9qT0
	mImVGS8GhFoU/DmqtIxe3plxwqFZ9L5uGUBMU7CgfPp5bXoS0EKVhYv/CupyAlak98imtRQN5Ql
	5ODa/TUB/PTkUndezlYJT2D9QxnrOuD877+BxLjiNpqgvHeH3JV1tGo/miZbXHc7ApPMbPMImqF
	7rrRgPySnlY0qfg/oq/l8xrLtTi2vd3gvr7oMDHwidT/l88D2uUpo46JCJemGU+4waP0wMQ
X-Received: by 2002:a17:907:9621:b0:b87:6f2:a486 with SMTP id
 a640c23a62f3a-b8edf30bbfbmr68105166b.31.1770350685578; Thu, 05 Feb 2026
 20:04:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
 <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
 <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com>
 <20260203101707.52965eb0@gandalf.local.home> <CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
 <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com> <20260205130459.0ff532f3@robin>
In-Reply-To: <20260205130459.0ff532f3@robin>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 6 Feb 2026 12:04:33 +0800
X-Gm-Features: AZwV_QhId58YvCZ3fM6iQiRZvfYIzbT5iOIHS7SNSi8TZMEDvlERMVw9UqQO5I8
Message-ID: <CAErzpmtHO1Fmkpy0j5ZdFTeSU18oVkUCACqKfm9r=RY=tjJOmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 2:05=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 4 Feb 2026 22:52:11 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > > > I have trace-cmd reading BTF now (just haven't officially released =
it) and
> > > > doing an extract and reading the trace.dat file is much faster than=
 reading
> > > > the trace file with arguments. I'll need to implement the enum logi=
c too in
> > > > libtraceevent.
> > >
> > > If you mean to do pretty printing of the trace in user space then +1 =
from me.
> > >
> > > I don't like sorting enums either in resolve_btfid, pahole or kernel.
> > > Sorted BTF by name was ok, since it doesn't change original semantics=
.
> > > While sorting enums by value gets us to the grey zone where
> > > the sequence of enum names in vmlinux.h becomes different than in dwa=
rf.
> >
> > Thanks, I agreed.
>
> BTW, I just officially released trace-cmd v3.4 (where you can see whats
> new in that release here[1]).
>
> The biggest change is that it saves the BTF file in the trace.dat file
> and parses it on the report (it requires libtraceevent v1.9):
>
>  ~# trace-cmd record -p function_graph -O funcgraph-args -g do_sys_openat=
2
>  [..]
>  ~# trace-cmd report
>        trace-cmd-50935 [002] ...1.  3490.518138: funcgraph_entry:        =
           |  do_sys_openat2(dfd=3D4294967196, filename=3D0x557bb9e3ee10, h=
ow=3D0xffff88815220fea8) {
>        trace-cmd-50935 [002] ...1.  3490.518141: funcgraph_entry:        =
           |    getname_flags(filename=3D0x557bb9e3ee10, flags=3D0) {
>        trace-cmd-50935 [002] ...1.  3490.518142: funcgraph_entry:        =
           |      getname_flags.part.0(filename=3D0x557bb9e3ee10, flags=3D0=
) {
>        trace-cmd-50935 [002] ...1.  3490.518143: funcgraph_entry:        =
           |        kmem_cache_alloc_noprof(s=3D0xffff888106c7e000, gfpflag=
s=3D0xcc0) {
>        trace-cmd-50935 [002] ...1.  3490.518145: funcgraph_entry:        =
           |          stack_trace_save(store=3D0xffff88815220fac8, size=3D0=
x40, skipnr=3D0x0) {
>        trace-cmd-50935 [002] ...1.  3490.518147: funcgraph_entry:        =
           |            arch_stack_walk(consume_entry=3D0xffffffff94d9dfe0,=
 cookie=3D0xffff88815220fa58, task=3D0xffff88812d4c3580, regs=3D0x0) {
>        trace-cmd-50935 [002] ...1.  3490.518148: funcgraph_entry:        =
           |              __unwind_start(state=3D0xffff88815220f988, task=
=3D0xffff88812d4c3580, regs=3D0x0, first_frame=3D0xffff88815220fa28) {
>        trace-cmd-50935 [002] ...1.  3490.518149: funcgraph_entry:        =
1.518 us   |                get_stack_info(stack=3D0xffff88815220f938, task=
=3D0xffff88812d4c3580, info=3D0xffff88815220f988, visit_mask=3D0xffff888152=
20f9a8); (ret=3D0x0)
>        trace-cmd-50935 [002] ...1.  3490.518152: funcgraph_entry:        =
           |                unwind_next_frame(state=3D0xffff88815220f988) {
>        trace-cmd-50935 [002] ...1.  3490.518153: funcgraph_entry:        =
0.951 us   |                  __rcu_read_lock(); (ret=3D0xffff88812d4c3580)

Thanks, I will implement this feature in libtraceevent.

>
> -- Steve
>
>
>
> [1] https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/tag/?h=
=3Dtrace-cmd-v3.4
