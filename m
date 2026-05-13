Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C0C4C9579
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690144; cv=pass; b=gVpqXcmWgGkSZ/eILAjFq25gphylEt6G7E1HBo3s33/mgM+htpfJQ7BgSeO7N9bbjntxvBcS1AVEVmG9lYY3O6FEeNfL88ausz6ft3oztjRVnjIvcgwPihmqdE79oG/kJtVdKWIXWp2PN18IubIWRv71DI9euuwZVIVswnWFzVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690144; c=relaxed/simple;
	bh=szTmaxP23lVkEVq/RlBkdxcb8V6CMoKd6fObh9S4BLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEcI7k3icD8jyncs2eO8jWyNvhaPOxyLBNrlOXBQI7DeAm1dzn6UdEpZN96ZxKH5XZSPfp1j3KX6lmXiuyv6LkujPR0pwMRu6pu3tPplRZrII2aALrCQehdgfzqHSVhWVdjYysENjnDOiFBdOsX+RHiNxhAcK0c510Ex2NbQwcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mnz0ReYQ; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mnz0ReYQ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44a044cb827so5606231f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 09:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778690141; cv=none;
        d=google.com; s=arc-20240605;
        b=F0CKMEw4p6TbvL1ltvnZiaudRZeFLOVU61Fw8q+ibIUGwvnb6CFjSW3WAU8bj7xtPY
         HhHP17nkIxNvClmIPMP8CXXvUDeeS3/BjI6jhGZE9Rx32mRBSDOP+lwKCIEePIE9gcbG
         sl3LuoxTiF4U3dq5thqbBtHVbqVerwxjnygy6GzjyjquPso8dHm+yd0nXXruG5ReA3IZ
         648XeDLvJ/Hc1BRVFXeukk+JQSQ7iVVAxYzcxT0UeOhyrwYXKEfbmVzlTlFQSltaZClx
         v9jMvnWY6BKXdcQ4SJhbkZ2HhBhCp9Ci6TkGECD3BxpbdvKfm5ZKOwVP8aJhCbCbQO9X
         9DQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=szTmaxP23lVkEVq/RlBkdxcb8V6CMoKd6fObh9S4BLA=;
        fh=pN0xDiWTLFrCVRCdS7TAJPZ38di8+F/Z6f7+7Ky6x00=;
        b=cjG3VftivL6cLVcyVJ8gKNt7SR7OBytM3ry9bYalVjcRXlapPRGHRNBNb/TgB6SwpF
         bo+ELNXDgZ08Ctabyhv6HtXIeotJ32KhKIU8G8ugv7wGk9kK0xigM9lXa9tmSk0GOUWZ
         2sWhY87/sbMoZZcMlLYdgpUX6wJahWXYRFKHbagh1qCzBqPKFTYEUGvfWj22e7wJaxnp
         kVVC5dCZ5CAVTw67hEGxEWxn8qg7vMeGHyi2awIuHrfGWeIkgEPwlZrqA+nfmM52e3kq
         HRXOLirs1AG59MxoYao0VN+4AJUUm+D0ya3yXe7z65ZLJkYzq1IjOxD+bUh0gGzeTyjC
         vDhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778690141; x=1779294941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szTmaxP23lVkEVq/RlBkdxcb8V6CMoKd6fObh9S4BLA=;
        b=Mnz0ReYQKxqtSGLn3aICTB8GIlcb+ejq6ZwbKM4a3OUMjot/T1uuBurp4GLGybwL67
         Rb/B/qxdy1v4CZx+l1zBz/nHAKRHHRXcbm8hkrDQq8CPcDWrihdqOHFxtoDaC67BKOIX
         JWLpcwoD3iDmIOLYv88btopPuluD3uue5f2qEtZ9khgGAROt4kJtrkrMP5cee5aDt0JH
         /2kdmlm44Mhf3Vk3N8xyb6V0IwxgR8oY5ancyKc4zdLtrK/A9oDCsMNsk86VahGnou0R
         tThTlKSFTv3SnccWMdyF/bARMgNVJOPBD38yLXsae0XT6IFINMdWwyuSJ1TJX0816x/h
         SAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690141; x=1779294941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=szTmaxP23lVkEVq/RlBkdxcb8V6CMoKd6fObh9S4BLA=;
        b=A2byDe/xKte3c/TpuVdZlNkiEckhT30XI0/Nvimcsr/xd6DZTGH+HfiLk6jP6XhDvN
         w9MNN7Puc3+K0EUohpOlrtThzkCQSiVxi1oZpn/JA6+7rqxVumOr3NnAuZ6M8FMlxDeA
         ntGJRqASHQXggkosuTaaMem6cJzHzJoAe7MwfBXn28c7JII+CxbmXHeq1XsJQmM3qblE
         c7hzE9Mj7C3gysM/M1akqovS7zQulumUFhnwo53GmHlTGYEXGihv/WKWYbSfppoZ0rUU
         /+Zum8bmMXBNxE0yeQ8x/ZqxGa7KlE1FiJogMMu6yZOm0OLK+CAfK4qboGXIyuaeJqLu
         IzVw==
X-Forwarded-Encrypted: i=1; AFNElJ8La3Fz9ZmFrMJ3j0rZtFH6BeSWmOj6Ia8NDuWx5Y6oXg7Da8MkEwsP9XMOuAVZC17JDNi93LxSUz7PH7pr/tCiL4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzna3gI/96WDFdL80lqk1sDUlHoT6DUIZDCytUCqcZlDiXGeVXz
	S3feYWJr+dck/OKtNsQ9jJF7lJ/CnB2PR5+GPe0PaL0fpxrKYvoQ35pBm0fZVfeNaWzszU0NTUk
	YXOwjQyfp0RItjiGizMqeaNUNS8IlKso=
X-Gm-Gg: Acq92OEAngZMWxlPUyJpT5LdjPb83w5NcvRp5rP/dCheCN+FJPzCO/shJr++jKXRsg8
	8wVZpgeKXb4tzsmf6sF4bNPzWXRF5Qc9rNjyKODE5BiusKm1EADvClPZu95LEVxg6TBGt7IX3df
	Wmau75j7VzC9XTGUZSlPfZL9Bl0pzXURTHjHfQWpH9Zm4dC12lp0CTb2PC4vqfUrhQNI+tE+4ZJ
	3GLlynclpMqL4ogFwAsMnr1UxZYSghGDSjdytRhKtlFwcEBhKvYAbyl5a+KxzzLA5Pxa8N7xETu
	cckSfXTK248m9tAEtXAeNOMY7K1223cGYaAS6cVKd+xo8NqShOWEgDKdFdwTEIRt04tyhdCuIX2
	q7b29svX1zXtALkxMceOpTPhO+BWz/38URNfJ
X-Received: by 2002:a05:6000:40da:b0:441:36b7:725f with SMTP id
 ffacd0b85a97d-45c790b29d5mr5681775f8f.5.1778690140854; Wed, 13 May 2026
 09:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503164700.548164-1-atomlin@atomlin.com> <CAADnVQJ5fatNF4auH+a8E39zWMfja3rm4BM_xGcTnLX8uuCQ9Q@mail.gmail.com>
 <20260513111331.7bede512@gandalf.local.home> <CAADnVQL_sWznA+JJLdzP_ZdUgQeO7p-AGnOtx9=fXjH+PnRJBA@mail.gmail.com>
 <20260513112307.53e77312@gandalf.local.home>
In-Reply-To: <20260513112307.53e77312@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 May 2026 09:35:29 -0700
X-Gm-Features: AVHnY4K_hlbgG6Weelv9JfOoNVR8uOv-dykIa4nZRH_llhP3bTFiLQRGwYl2Ss4
Message-ID: <CAADnVQLw+_NaOVeaKabuf085wNo_-6MAv8w0EDO3fBz3KCQT5g@mail.gmail.com>
Subject: Re: [RFC PATCH v3] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap <rdunlap@infradead.org>, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 8:23=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 13 May 2026 08:16:07 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > It's impossible to track all modifications.
> > See what sched-ext is doing.
> > What does it modify? Everything.
>
> What about just having a list of what BPF programs are loaded, what they
> may be attached to, and what kfuncs they are calling?

Ohh. These have been available forever.
Just bpftool prog, bpftool link, bpftool prog dump xlated
