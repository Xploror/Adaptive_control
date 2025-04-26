function P = calc_P(A)

P = lyap(A', eye(length(A)));

end