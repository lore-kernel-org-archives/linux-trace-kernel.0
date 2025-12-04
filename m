Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089519D8A8;
	Thu,  4 Dec 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764855166; cv=pass; b=t2XhaNw++oxUVTpLD/kP/7Ub9/CtXUPMM3uGcgi70DmLhh2c6tIvkPlyvu+YS9T67lgIjEOVhrEM6n7YIzxkxMR1mq63LraizHtuPSGEkzRPtHVnS69H6cx0xD7MTQXPmCl7x8gaEm2dR3jZTITXKNp8NoE3tMipyJg2Ejn7lpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764855166; c=relaxed/simple;
	bh=+4kfdPwLfzGDz5DooGDQ3i4oc2aC0m9pze+1u/slBxg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ImO1oPEO5GMv32e4wgMENN/oTI3eH8NXEQk/hnGZ5IZR2/5Wed+BFsIBq7XM/MBpoQYZTh6JpwwPZxalt4m+32OOzyM0a3dQUx17aORFlrdvQQvgRwrsL2Z8lih1T/jyH95JZwf1rXH83HtWaAZL4lJU4PFuHQr2DcoEHlSvm20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=hcn2N/ff; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="hcn2N/ff"
ARC-Seal: i=1; a=rsa-sha256; t=1764855141; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c7/XbhCyynP8lAhbVNAYcYc0vAjgfD30G79m8OF5F/u9xcXeQcN1FJoJpWGo0f/sKF0c0QX9OM6QyzwmtxuhZHza4ndW7PirVrgmrt72ZJghhnN1jnmwcp46Nx7c1nzoz+E7hmSQNHhZK5GTq/Dh5c6A4P92nsZZlz9fAkLNDCY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764855141; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lPnJaT1HdHVr/f2MfdggNjlsduGINqvWcdCcmQNsGDA=; 
	b=eQwS2KVxGSwQW8HFlHk1QEkCz8lqwVIXSjOPbS2QUpb1zm7SgXkGWX7pCAJVu0eDLfIcRrU/8spLFKk7R6dwB1EroUak05amtwQb+KCk9VBax/3RsCOTv/HfH1dl2RBk6RCpzwnd4j1cvzn8d6Xb5VMs2SI9nF22ZGU9IhAFkxc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764855141;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=lPnJaT1HdHVr/f2MfdggNjlsduGINqvWcdCcmQNsGDA=;
	b=hcn2N/ffp1JBZ4aHnIQVFqmj5FcsVJkHoHpnPCIK3PoiLZZ/xKJLnDKODGGHRS0o
	1LX8DN+zt6oxgtAzF9nOGb5zglPLoAqsZQmUbZ7+yRQwKtdjJPqxbdV+stN4gocI6Wr
	C9z/jTkEh9a2IRSujcdese3DcuWk0urVJ9X/ih88=
Received: by mx.zohomail.com with SMTPS id 1764855140264706.937872752772;
	Thu, 4 Dec 2025 05:32:20 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 1/2] rust: sync: add Arc::DATA_OFFSET
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20251203-binder-trace1-v1-1-22d3ffddb44e@google.com>
Date: Thu, 4 Dec 2025 07:32:09 -0600
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Carlos Llamas <cmllamas@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>,
 Martijn Coenen <maco@android.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Christian Brauner <brauner@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 rust-for-linux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <70CF53DF-175E-4687-A719-6C992C69CC0A@collabora.com>
References: <20251203-binder-trace1-v1-0-22d3ffddb44e@google.com>
 <20251203-binder-trace1-v1-1-22d3ffddb44e@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 3 Dec 2025, at 08:48, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> This constant will be used to expose some offset constants from the =
Rust
> Binder driver to tracepoints which are implemented in C. The constant =
is
> usually equal to sizeof(refcount_t), but may be larger if T has a =
large
> alignment.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> rust/kernel/sync/arc.rs | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index =
289f77abf415a2a52e039a2c0291413eda01217c..921e19333b895f0d971591c4753047d0=
248a3029 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -240,6 +240,9 @@ pub fn new(contents: T, flags: Flags) -> =
Result<Self, AllocError> {
>         // `Arc` object.
>         Ok(unsafe { Self::from_inner(inner) })
>     }
> +
> +    /// The offset that the value is stored at.
> +    pub const DATA_OFFSET: usize =3D =
core::mem::offset_of!(ArcInner<T>, data);
> }
>=20
> impl<T: ?Sized> Arc<T> {
>=20
> --=20
> 2.52.0.158.g65b55ccf14-goog
>=20
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
