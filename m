Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308FB74BE1
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Jul 2026 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950475; cv=pass; b=WLtt6YXnQMiTvGrxZCZtbjXP3Z2cvnqTCY+0DE/7Onnq3M26rllKAGalgQOcK5lVZPAOJwtKabmdrGyUiOyqpAGvnpXmjaM1HYr1OuSGP4BqYmjRcHAx65ZNmlmVk3DRNVDgYMVWsg+F9nOxV6HdsvOVQ3U1jbxBEmFWLEmzjBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950475; c=relaxed/simple;
	bh=h7F8Hea6IuFuXhEfwJYVnVQjGYALLY6z0SeCgrb7pFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T12vbgIlRXvTMcK9BSco9jn4JMVkhd5MSZ4EE5yTXIoY1MxkT9bLYU017UxMOwpLFuwS4z1YyGp+7b5zlM1Hg8NK4B3lWRjMWxKdvHMuLUfulFeRaSja+3lFSiceu5Bj9+8eMlLF0ZFdHUMiIGPa3YBV1P69zH+bp7eRSX2ifQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyoXQ1EE; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyoXQ1EE"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8478fe07f65so932902b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 17:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782950473; cv=none;
        d=google.com; s=arc-20260327;
        b=nUUNRBUEB36o2WiE79MIyclNBc/spHh9FlJe+mXEc5YWKNoSTp7fENyFcgU0I0lR7l
         x80qy2pg/nO7zkZROcK4cfoBY+X6i8Dd/7cJvk30YY9Mg9hlj3l+IUrdiHShGVzac3XP
         fKNqvSiPbp1FNGrDl5YVs4LQKfrFm8mTMwG3amW/sjHKHo72GKxLSK5WBy0TfpLFwHMc
         DbJj3kAApcHauuuac09ybEcKhTJAzImaKEb2GmAkLE64A3htysXRX1QtglFD3UXc1Sff
         83xzJ/XQRi454fZ+18PVTG/YfNoAfxdFgRjRQS6M9Jov3pr5jWIqE3Htr8asthCI6hhc
         II+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h7F8Hea6IuFuXhEfwJYVnVQjGYALLY6z0SeCgrb7pFE=;
        fh=Jp1+vsJOKifz0MXF3hTXZ/ahJVmzEMG8B1sRaliCglM=;
        b=pWFLALkPWTnYbeQ8UpIHZMsPPqxvBPPwmZXWeLobkfFkPxiuTaNkfrVqb+ulbyAxfQ
         STIdsR70Jgptd0NHZOJrRVJJfs6uCPkxu4PNZ25fq0RMniBNXw+sgulccD5XrQEyh1JU
         dc4awEaU7CkfAWmD4nch4Ujnwqwcrsog5w77iXhPylQtlPFi1b9mavTYXObnYdK8QSoX
         NS0Cj9fEuuC5V9iYIIvoIMY1lSw8NpVgZ5qIkNFbDfwvtfjne3hWjbwaXsrwq+Sg5ya/
         HNIhWeQWHTUEBJJ3YLy44BQMiRS62+wit6vWjHnSkyqx5WabYUAwtOmi1ELdEgbrD3ND
         arsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782950473; x=1783555273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7F8Hea6IuFuXhEfwJYVnVQjGYALLY6z0SeCgrb7pFE=;
        b=lyoXQ1EErjH7PjP3Ijggvk+B4EADZpMT4ykcRN6Eo7bLcgve7oHwh53RNh+YVSEUvd
         huK1Snljy7Drp51UsgxlrMyKd8lpnxAppnUnqVwDjsHfyyhE7/FDuKe6eFj1w9eTH2E+
         DRbeSNlwp6kat59q2oWWWXPQPUMlwkI7MB61So3K+GalUrsj8s2wlvkcVJ/XSFI8rsEs
         FtF029G1RE13rtcXrVqSW2BdRsYT6DPSj/zB95rhS1HohKdT05C+uxkvoTfh+FD05QcN
         Sop1OLHXBJykSsQkybEz13ixvi/b4+CqlgeSF7bfVpCRLR9cCfCzwv1IJXUUNK0CAdnm
         amww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782950473; x=1783555273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h7F8Hea6IuFuXhEfwJYVnVQjGYALLY6z0SeCgrb7pFE=;
        b=Bw8e2B86NZhgDrwrtRLHGOwOC7x2Dg5IHXTTTX8beJlmo4wTyzqN3O4glhX7wZRYMw
         wcmXDQVBroGXtbqgdywHVSGRsEiii1VX+tJmbMMAuWlwpPacS4RVimwF1WmCKae/VFOH
         SzFOLSsWfyfVrlpgtXKbsc6NbYXZnAsjd3qC94yR6mamrzpLf8kSz7IY4A1JaT8PiLxi
         hnCNgzJIQRC6aQsWjwBoRnw22a5yxYfe3th5x0UmKPla5FlRRIFCElD201alHASbZo7N
         zYHKzoVIrymOGPhULVCmv2f11hFhpdOzbiVLNrHwv44xjZIfQHbsmCOz+AIojMu7A0Sd
         cPMw==
X-Forwarded-Encrypted: i=1; AFNElJ/LWLlrIYyEQCdPKt2277l4J7V63zf/V4xKGU2uiWD7jeDTqLBJYAV5hG2UkcER5LsuhMTwzE9cg0QDEG08iM01Ue0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHrG/DWOltX+3KfbOVDlYfzzvPizb98ZnEDTvflgD5xTptyAiA
	IWsAWUiBuryRk2DuMV+omg5+PUvolYh4fTQE7ZeHYSzB4qmy2rmlOvM+ytTmf1XWIWmdT+3o9Mn
	1b2LDVg2YzIbHvZH8Z1CSjZHsAxFT3F0=
X-Gm-Gg: AfdE7cmF7E+9eX3qxmgZfv5D/sGNFmYEVc4Pkw08SIOIsl2eHNdDg6XQKxZVMkuZ32j
	6H3VInmAeIH4qOjyMuEEfTPeoKX3K2GJ+9AEGrB4/EVGSH6SUegCzk5XDUWmDzgJtYj8kMJ4AZU
	jteEeAB4O+PJi+WI31C5HKwWPZTqpujvFCU7gG9bIlfj3BEHkXoEa2nfS/x7sBcLuWJDLrTysiP
	E6hDI5LsYt7vTNZZmUxYrnjJXqoS7+eOOijX0a2/UfzG/W+w9W1AXvWI/6r/zANJporjCc/FQIp
	K7G3Ev0QeE+Z7S+Z/2MHGoC0O0Cj1o/rrUki1nR+dF7YP8UDlXyj3bJM6WibKUDWEQ5AXZTJ3Nn
	7D2RwvLRoUdLdPw==
X-Received: by 2002:a05:6a21:6f8b:b0:3b3:26aa:5455 with SMTP id
 adf61e73a8af0-3bfed15c303mr4004694637.13.1782950473171; Wed, 01 Jul 2026
 17:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
 <178291354144.1566898.14374948740441958770.stgit@devnote2>
 <DJNGE5JG5ZY4.FEO5DZ21TL7Z@gmail.com> <20260702074007.e1047c9d66cbcecc7d4ab3a9@kernel.org>
In-Reply-To: <20260702074007.e1047c9d66cbcecc7d4ab3a9@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Jul 2026 17:01:01 -0700
X-Gm-Features: AVVi8CeNxG3GffX-OwXo6mb147DD5vMthLu_C49lWR5Of1AKIMhyjJfW9B4eScU
Message-ID: <CAADnVQLUniyTM64gHrLzgjWiNZTB82tT0LCxh8D29YfXG7cZ6w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] tracing/probes: Compile all fetchargs into a
 single BPF program per event
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 3:40=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Wed, 01 Jul 2026 11:41:26 -0700
> "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
>
> >
> > Nack.
> > I really don't like it.
> > There were days in the past when the kernel generating bpf directly was=
 appealing.
> > These days are gone. Performance improvements for fetchargs is not a go=
od reason
> > to add all this complexity and bypass verifier checks.
> > bpf insns should come from user space.
>
> Thanks for your comment!
> OK, I don't mind because this is a kind of investigation project. And som=
e
> people had asked me about the same idea, now I can tell them the result.
>
> I'm satisfied with the current outcome, as this development process gave =
me
> insight into the implementation of BPF and demonstrated the potential for
> optimization via JIT. :)
>
> And also, as noted in the cover letter, the current performance of fetcha=
rg
> is better than I thought, and is good enough for debugging. :)
>
> BTW, I'm also interested in calling the verifier on this generated code.
> Even it it is not merged, I think showing the correct way to implement it
> will be useful in the future.

The whole feature you're trying to do is imo reinvention of the wheel.
bpf could do that kind of filtering years ago.
I don't buy the excuse that embedded environments without any
kind of user space needs this facility.
