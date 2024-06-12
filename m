Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CB217E453;
	Wed, 12 Jun 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204612; cv=none; b=AIgb9LUhJ8/q1Kr1ukp7g+Uf8904NIlEzuekHOx9a4DzB8j+ddTwkKDEIT0F0hwrQa2zH/j9YGZ0HNNw6+FvPba6K6wFBVHXEGr/ytOSZVOjao6x8Zl3icRJL5x1uy1zeRGH7eaktDTzj9yYhzzH4REaCRmYfzEn+zHxmlerKBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204612; c=relaxed/simple;
	bh=AMq+F3yP0qGn6PUexLUcixWqx9UsBEvmZ9R2Pl/8kHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNPKOXbUDqblUw7IaJpS6JRr154QXzPwg8z89RsdLwlMgb47JPKO5mxdMk7FPeRoP3ur+TbIl7De5KAC3thpOeTdBW4cIr/Wi7lCf2N5qbVmK4Ho0GtEljRtHda4zNlH9Jgv2U6QStAu++kCYvLUysa6V70+wsLxeUeHBMSkrC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQHWPMJ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQHWPMJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C183C4AF1C;
	Wed, 12 Jun 2024 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718204612;
	bh=AMq+F3yP0qGn6PUexLUcixWqx9UsBEvmZ9R2Pl/8kHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQHWPMJ+5hGMi0F461js4qxDtCy4IJCGyS8bEOqXjH/kAhYAfaVoDyLM6/Zm/q2Tn
	 W5uP5rdZByPJB3TTvH08RBGP12xYSy/zkIDqI3IRktJMm7RI2SUngPGUvvChlsG40m
	 Rz61i7IMuwWD70bxt9xXtK2Egqahp7JLlefBtw3tqB8Zfs46Zerh5NWBWFRsCzsNZL
	 LlvQ40aT7fIWt1L3V/nQB+Okg7xsTqm9vYXo9iP1zYnwmtnKGZQ51pHqW4B3Ok1V5O
	 d7LkxN4tn4d7ume7QOSSR+LA7KEt2IuRv98d8l7q+eIQB0rSgLA3tKyEDPYhc0T2yx
	 DHHSXJ+L/57Fg==
Date: Wed, 12 Jun 2024 16:03:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: add static_key_false
Message-ID: <20240612-cottage-revision-9842e7e22070@spud>
References: <20240610-tracepoint-v2-0-faebad81b355@google.com>
 <20240610-tracepoint-v2-1-faebad81b355@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dUAfOGkLLXcIvSlP"
Content-Disposition: inline
In-Reply-To: <20240610-tracepoint-v2-1-faebad81b355@google.com>


--dUAfOGkLLXcIvSlP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 02:01:04PM +0000, Alice Ryhl wrote:
> Add just enough support for static key so that we can use it from
> tracepoints. Tracepoints rely on `static_key_false` even though it is
> deprecated, so we add the same functionality to Rust.
>=20
> It is not possible to use the existing C implementation of
> arch_static_branch because it passes the argument `key` to inline
> assembly as an 'i' parameter, so any attempt to add a C helper for this
> function will fail to compile because the value of `key` must be known
> at compile-time.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

> +#[cfg(target_arch =3D "x86_64")]

> +#[cfg(target_arch =3D "aarch64")]

This patch breaks the build on riscv (and I assume loongarch):

error[E0432]: unresolved import `_static_key_false`
--> /stuff/linux/rust/kernel/static_key.rs:87:10
|
87 | pub use {_static_key_false, static_key_false};
|          ^^^^^^^^^^^^^^^^^ no external crate `_static_key_false`

Cheers,
Conor.


--dUAfOGkLLXcIvSlP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmm4vgAKCRB4tDGHoIJi
0pVkAP9EeMhX3Q/hwLb+de1F64FhI0DaOk0yQebsR9xD6ZE8VgEAlwzOITVeEvJ2
iMqajvY89XlzKAdwizJAOPQ+h/BZwQk=
=xvXY
-----END PGP SIGNATURE-----

--dUAfOGkLLXcIvSlP--
