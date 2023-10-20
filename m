Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1631D54A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E4VuVZdJ"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91CC2D46
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:26:20 -0700 (PDT)
Received: from pwmachine.localnet (unknown [188.24.154.80])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0926820B74C0;
	Fri, 20 Oct 2023 07:26:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0926820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1697811979;
	bh=p6gymtymqcNBNZ8i90kW5zqUS03/uCqyJNPiohXVzYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4VuVZdJ+kPnREpI2HiNe0fCNGj1iOiEytNV5weM51IcsEWAbhfriE1Cf6YHDs5RG
	 2zKsr369Z4lEax9NNTKvj/WBue1Q6+wzCse927JjkDwwZ//mnDg2UaUu31d5H8oPpX
	 crHxTced8IWqf+K+uFktNFcu6Qf5a/GgCY0AJ/nU=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v6 0/2] Return EADDRNOTAVAIL when func matches several symbols during kprobe creation
Date: Fri, 20 Oct 2023 17:26:16 +0300
Message-ID: <4868783.31r3eYUQgx@pwmachine>
In-Reply-To: <20231020211239.85855928dedb0f5128143f2a@kernel.org>
References: <20231020104250.9537-1-flaniel@linux.microsoft.com> <20231020211239.85855928dedb0f5128143f2a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi!

Le vendredi 20 octobre 2023, 15:12:39 EEST Masami Hiramatsu a =C3=A9crit :
> Hi,
>=20
> Thanks for update the series. The series looks good to me.
> Let me pick those in probes/fixes.

Thank you for picking it and all the good advices during the development=20
process!

> Thank you!

Best regards.

> On Fri, 20 Oct 2023 13:42:48 +0300
>=20
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > Hi.
> >=20
> >=20
> > In the kernel source code, it exists different functions which share the
> > same name but which have, of course, different addresses as they can be
> > defined in different modules:
> > # Kernel was compiled with CONFIG_NTFS_FS and CONFIG_NTFS3_FS as built-=
in.
> > root@vm-amd64:~# grep ntfs_file_write_iter /proc/kallsyms
> > ffffffff814ce3c0 t __pfx_ntfs_file_write_iter
> > ffffffff814ce3d0 t ntfs_file_write_iter
> > ffffffff814fc8a0 t __pfx_ntfs_file_write_iter
> > ffffffff814fc8b0 t ntfs_file_write_iter
> > This can be source of troubles when you create a PMU kprobe for such a
> > function, as it will only install one for the first address (e.g.
> > 0xffffffff814ce3d0 in the above).
> > This could lead to some troubles were BPF based tools does not report a=
ny
> > event because the second function is not called:
> > root@vm-amd64:/mnt# mount | grep /mnt
> > /foo.img on /mnt type ntfs3 (rw,relatime,uid=3D0,gid=3D0,iocharset=3Dut=
f8)
> > # ig is a tool which installs a PMU kprobe on ntfs_file_write_iter().
> > root@vm-amd64:/mnt# ig trace fsslower -m 0 -f ntfs3 --host &> /tmp/foo &
> > [1] 207
> > root@vm-amd64:/mnt# dd if=3D./foo of=3D./bar count=3D3
> > 3+0 records in
> > 3+0 records out
> > 1536 bytes (1.5 kB, 1.5 KiB) copied, 0.00543323 s, 283 kB/s
> > root@vm-amd64:/mnt# fg
> > ig trace fsslower -m 0 -f ntfs3 --host &> /tmp/foo
> > ^Croot@vm-amd64:/mnt# more /tmp/foo
> > RUNTIME.CONTAINERNAME          RUNTIME.CONTAIN=E2=80=A6 PID            =
  COMM
> >=20
> >   T      BYTES     OFFSET        LAT FILE
> >  =20
> >                                                 214              dd
> >  =20
> >   R        512          0        766 foo
> >  =20
> >                                                 214              dd
> >  =20
> >   R        512        512          9 foo
> >  =20
> >                                                 214              dd
> >=20
> > As you can see in the above, only read events are reported and no write
> > because the kprobe is installed for the old ntfs_file_write_iter() and
> > not the ntfs3 one.
> > The same behavior occurs with sysfs kprobe:
> > root@vm-amd64:/# echo 'p:probe/ntfs_file_write_iter ntfs_file_write_ite=
r'
> > > /sys/kernel/tracing/kprobe_events root@vm-amd64:/# cat
> > /sys/kernel/tracing/kprobe_events
> > p:probe/ntfs_file_write_iter ntfs_file_write_iter
> > root@vm-amd64:/# mount | grep /mnt
> > /foo.img on /mnt type ntfs3 (rw,relatime,uid=3D0,gid=3D0,iocharset=3Dut=
f8)
> > root@vm-amd64:/# perf record -e probe:ntfs_file_write_iter &
> > [1] 210
> > root@vm-amd64:/# cd /mnt/
> > root@vm-amd64:/mnt# dd if=3D./foo of=3D./bar count=3D3
> > 3+0 records in
> > 3+0 records out
> > 1536 bytes (1.5 kB, 1.5 KiB) copied, 0.00234793 s, 654 kB/s
> > root@vm-amd64:/mnt# cd -
> > /
> > root@vm-amd64:/# fg
> > perf record -e probe:ntfs_file_write_iter
> > ^C[ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.056 MB perf.data ]
> >=20
> > root@vm-amd64:/# perf report
> > Error:
> > The perf.data data has no samples!
> > # To display the perf.data header info, please use --header/--header-on=
ly
> > optio> #
> >=20
> > In this contribution, I modified the functions creating sysfs and PMU
> > kprobes to test if the function name given as argument matches several
> > symbols. In this case, these functions return EADDRNOTAVAIL to indicate
> > the user to use addr and offs to remove this ambiguity.
> > So, when the above BPF tool is run, the following error message is
> > printed:
> > root@vm-amd64:~# ig trace fsslower -m 0 -f ntfs3 --host &> /tmp/foo &
> > [1] 228
> > root@vm-amd64:~# more /tmp/foo
> > RUNTIME.CONTAINERNAME          RUNTIME.CONTAIN=E2=80=A6 PID            =
  COMM
> >=20
> >   T      BYTES     OFFSET        LAT FILE
> >=20
> > Error: running gadget: running gadget: installing tracer: attaching
> > kprobe: crea ting perf_kprobe PMU (arch-specific fallback for
> > "ntfs_file_write_iter"): token ntfs_file_write_iter: opening perf event:
> > cannot assign requested address And the same with sysfs kprobe:
> > root@vm-amd64:/# echo 'p:probe/ntfs_file_write_iter ntfs_file_write_ite=
r'
> > > /sys/kernel/tracing/kprobe_events -bash: echo: write error: Cannot
> > assign requested address
> > Note that, this does not influence perf as it installs kprobes as offset
> > on
> > _text:
> > root@vm-amd64:/# perf probe --add ntfs_file_write_iter
> >=20
> > Added new events:
> >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> >   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> >=20
> > ...
> > root@vm-amd64:/# cat /sys/kernel/tracing/kprobe_events
> > p:probe/ntfs_file_write_iter _text+5039088
> > p:probe/ntfs_file_write_iter _text+5228752
> >=20
> > Note that, this contribution is the conclusion of a previous RFC which
> > intended to install a PMU kprobe for all matching symbols [1, 2].
> >=20
> > If you see any way to improve this contribution, please share your
> > feedback.>=20
> > Changes since:
> >  v1:
> >   * Use EADDRNOTAVAIL instead of adding a new error code.
> >   * Correct also this behavior for sysfs kprobe.
> > =20
> >  v2:
> >   * Count the number of symbols corresponding to function name and retu=
rn
> >   EADDRNOTAVAIL if higher than 1.
> >   * Return ENOENT if above count is 0, as it would be returned later by
> >   while
> >   registering the kprobe.
> > =20
> >  v3:
> >   * Check symbol does not contain ':' before testing its uniqueness.
> >   * Add a selftest to check this is not possible to install a kprobe fo=
r a
> >   non unique symbol.
> > =20
> >  v5:
> >   * No changes, just add linux-stable as recipient.
> > =20
> >  v6:
> >   * Rephrase commit message.
> >   * Add "Cc:" to stable.
> >=20
> > Francis Laniel (2):
> >   tracing/kprobes: Return EADDRNOTAVAIL when func matches several
> >  =20
> >     symbols
> >  =20
> >   selftests/ftrace: Add new test case which checks non unique symbol
> > =20
> >  kernel/trace/trace_kprobe.c                   | 63 +++++++++++++++++++
> >  kernel/trace/trace_probe.h                    |  1 +
> >  .../test.d/kprobe/kprobe_non_uniq_symbol.tc   | 13 ++++
> >  3 files changed, 77 insertions(+)
> >  create mode 100644
> >  tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc=
>=20
> > Best regards and thank you in advance.
> > ---
> > [1]:
> > https://lore.kernel.org/lkml/20230816163517.112518-1-flaniel@linux.micr=
os
> > oft.com/ [2]:
> > https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@ke=
rn
> > el.org/ --
> > 2.34.1




