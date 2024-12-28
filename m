Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B715B115;
	Sat, 28 Dec 2024 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735393990; cv=none; b=bCOAlQcEU586gCg0q/Ql+YfnBCUWPjdhPjpkcsSqbWqTnKobK3QlAKAh5jJZuqrivskAjeEC8aWOsO7WaUzSZkXecm5GYaliVSqlMrut+d8wO+DoM08XK/F8NjKNuSVL2PRPz21yIkH8UA5yadP5qCOzN4f3lVnj6N+KobPmcMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735393990; c=relaxed/simple;
	bh=fRq0GBaIXFe7XmvZuBbEBPTh1+c15qLxexwoIqN3Fec=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=fw+BxeOQ9KJm7ydgZFAP/3FvXIwDGKZsHgAgo0w1Xo9JZ0iGfL601f9PpOwtoCY+vQijJu2fh6FrI+DGI1wTTv3s3O0KSeUnT7t2wlPq0f11iB2FOme63bdf+oW2TAVX2BMHYuX08ZVbf96TjZfm3Bfi3v2eOhgq7PN49wTaXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SGHBXKlQ; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SGHBXKlQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735393978; x=1735998778; i=markus.elfring@web.de;
	bh=fRq0GBaIXFe7XmvZuBbEBPTh1+c15qLxexwoIqN3Fec=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SGHBXKlQa30tgXazxznQ6l/UrXk21BTKh2uxNoQk9x896KOm5RXldhCmOUM9V/kd
	 7y+763RHeMgsZvjc/iwiXfTUcyiam8UzG6pR0f2i8UpuGysMzgDCX8H2BoOovh1ZF
	 J0/DIi5XQmcjkcE+LmrlNOFVPWwghI7aJY0Rp5Unvc81RUOSPU/QivKrhzmhaETAB
	 4Q+NVWadT7fxkWif7KssYrJXQFTMF9he2TQozl2UR9+8+gVNpuWW1LQ3vUISwoJ0m
	 3v/rE+61OpAbiobZHFwLh9URgGPCJrIKZaG/El/+W7t5sTiHI2Um52a4I5jjS0LwI
	 b2Em1ySjnRbBV1nkbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.40]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mav6f-1u3u090YOp-00cNwD; Sat, 28
 Dec 2024 14:52:58 +0100
Message-ID: <4b94cc1c-1ebf-4ab7-9ad1-8d335898b9b4@web.de>
Date: Sat, 28 Dec 2024 14:52:56 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20241226143936.005221995@goodmis.org>
Subject: Re: [for-next][PATCH 08/15] tracing: Switch trace_events_trigger.c
 code over to use guard()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241226143936.005221995@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e3ZEpUunk/Xube451Kilvl0d7v159lJwxh/SLIoHYBlmT/GR1EH
 5xL1LuTAO122wcTOvnCOJYfNzszQhAezLAhIXvpBZrJ2xLy9C2xOewDBUTJx9D3V9hZuYbe
 eiKM9riSMFLQyPUlCGd1dF9500Blkuhc8HIdOryOKToqPQOVaH75SHaXXj86Old0Lfl1gIc
 eUN9wDeCqO/Yyrh6DRqwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bpZT8OYUrms=;NsDEQ6Iuq/BfHsJCqXa6w80kGUJ
 4pi9CVLwfO3NA/xq3zQmEpg+k9TQaiy8JYDsAw+JbeS2LAY80igs0DVsakhcZLx28qYZ/QEPO
 O8VO6D+qZA2DPqSsb05jHoMN3jjxvjB5DsVSivYzMa3cVEYVe4zKinnq1e3BLT0XXDQdR+c7M
 Q4tEUuQcQKku1PS0qTavIbH29vygKzLCnVq3vmk2eA42pauM7cDgrnztdhOwAO3k4hsEaWU36
 /ZmVSbC4emWLIImf5kJzf3vKyo9I0K6ZymLzd5AxJ9POD1lo1NZPusEazCc5E/aowMg4PwcHG
 964wa8mJcOETQERVqlt6zquQJow8wUI3s/fxjY5QpRj73sDNXhpTmgp3QhjpjSC2qTone0lYn
 /mHyPK1lEf1d7Je8nylyheuB55M9IkQ9aRScLxVpEEB9K/f2o32jMw7FZG15dEuhvSVVhBYma
 Slv/Uu39SbYebNwlct6873m+WXpF0IGmx785vI7hjClTMSbR6QXZD24K8ofWOK+6CUxZ2X4qz
 JQe3ie+W2QQ9IvJA6iuKACB4xSvbOhT0EiXi9C6W7HkoSmC6c8qjkyohWJ2daD5poBon1gMJQ
 JVIGjq0ekKUpU1f/C1BWE+huPHcODxRrXN2HkgMW3uK/iewIjPs5f9qOuuLjanW27GxvL7xD4
 8+3gxoszU7VCFRwfrUVFnO7N1SaPInDIuPnb2KFhKAf6LREofEhPKwpsi0AKWmKT0a/tHOUP9
 3gk+hruovelMuMpLCz8aFSHEAOwJ1GwUbTHOPy6q97fdVNPUf689e65C+EKqkm02ATy5e2cNk
 NnhSu9i//uZsHtH+J3PyaiFX41m7m0P7hzqozPOZhQ3F4iHHvKVvbg83ILeGGXNryn7+r6usB
 Vr39Fn0GygRvHFKZsv0+DqTpDW7oYJQGDA4LdH+gEzWR58rL6t2Apx+PCa5zK46UEa8TLjEal
 BKeP7ZxSk3AhTNzpKUD7V+Mok9H4TiexOg/7NOGwEyePTGOm3hIlCHwxNdYgMk2nDGWp6Q61G
 Q1yTnz+ip3g6w9PuNBh+Hpr5anzeCGfA2gxS5Yz/g2Jno7ApQ8Tz83/AzojMwkTqDMqHQq8Ex
 +VmbRFYdo=

=E2=80=A6
> Switch every location that ends with unlocking a mutex on error over to
> using the guard(mutex)() infrastructure to let the compiler worry about
> releasing locks. This makes the code easier to read and understand.
>
> Also use __free() for free a temporary buffer in event_trigger_regex_wri=
te().

Can it be safer and cleaner to split adjustments for these programming int=
erfaces?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.13-rc4#n81

Regards,
Markus
